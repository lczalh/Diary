//
//  LogisticsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ExpressQueryViewController: DiaryBaseViewController {
    
    /// 快递公司模型
    public var commonExpressCompaniesModel: Array<CourierEntranceModel> = []
    
    lazy var expressQueryView: ExpressQueryView = {
        let view = ExpressQueryView(frame: self.view.bounds)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    lazy var viewModel: ExpressQueryViewModel = {
        let vm = ExpressQueryViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(expressQueryView)
        // 标题
        self.tabBarController?.navigationItem.title = "快递查询"
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        // 返回
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.tabBarController?.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 监听文本框内容
        expressQueryView.textField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
                        .throttle(0.5) //在主线程中操作，0.3秒内值若多次改变，取最后一次
                        .map{$0.count > 0}
                        .drive(onNext: { (state) in
                            self.expressQueryView.inquireButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#57310C") : LCZHexadecimalColor(hexadecimal: "#bfbfbf")
                            self.expressQueryView.inquireButton.setTitleColor(state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : UIColor.white, for: .normal)
                            self.expressQueryView.inquireButton.isEnabled = state
                        })
                        .disposed(by: rx.disposeBag)
        
        // 查询按钮响应事件
        self.expressQueryView.inquireButton.rx.tap.debounce(0.3, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
            self.expressQueryView.inquireButton.isEnabled = false
            self.viewModel.inquireExpressLogisticsInfo(number: self.expressQueryView.textField.text!).subscribe(onSuccess: { (model) in
                // 记录
                self.viewModel.storeHistoryQuery(text: self.expressQueryView.textField.text!)
                DispatchQueue.main.async(execute: {
                    self.expressQueryView.tableView.reloadData()
                    self.expressQueryView.inquireButton.isEnabled = true
                    diaryRoute.push("diary://homeEntrance/courierEntrance/expressQueryResults" ,context: [model,self.commonExpressCompaniesModel])
                })
            }, onError: { (error) in
                self.expressQueryView.inquireButton.isEnabled = true
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        
      
        
    }
    
    /// 删除指定的历史记录
    ///
    /// - Parameter sender: 当前按钮
    @objc func deleCellQuery(sender: UIButton) -> () {
        let cell = LCZGetSuperView(currentView: sender, superView: UITableViewCell.self)
        let indexPath = self.expressQueryView.tableView.indexPath(for: cell!)
        let historyQueryHistoryQuery = self.viewModel.getHistoryQuery().mutableCopy() as! NSMutableArray
        historyQueryHistoryQuery.removeObject(at: indexPath!.row)
        historyQueryHistoryQuery.write(toFile: self.viewModel.historyQueryPlist, atomically: true)
        DispatchQueue.main.async(execute: {
            self.expressQueryView.tableView.reloadData()
        })
    }


}

extension ExpressQueryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getHistoryQuery().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryQueryTableViewCell", for: indexPath) as! HistoryQueryTableViewCell
        cell.titleLabel.text = self.viewModel.getHistoryQuery()[indexPath.row] as? String
        // 删除指定的历史记录
        cell.deleButton.addTarget(self, action: #selector(deleCellQuery), for: .touchUpInside)

        return cell
    }
    
    
}

extension ExpressQueryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
        }
        titleLabel.font = LCZFontSize(size: 14)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: "#57310C")
        titleLabel.text = "历史查询"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
