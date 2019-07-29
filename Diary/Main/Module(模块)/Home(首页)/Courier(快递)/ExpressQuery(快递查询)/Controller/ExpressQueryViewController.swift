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

        // 下级控制器返回按钮
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: AppContentColor)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        // 监听文本框内容
        expressQueryView.textField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
                        .throttle(0.5) //在主线程中操作，0.3秒内值若多次改变，取最后一次
                        .map{$0.count > 0}
                        .drive(onNext: { (state) in
                            self.expressQueryView.inquireButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: AppTitleColor) : LCZHexadecimalColor(hexadecimal: "#bfbfbf")
                            self.expressQueryView.inquireButton.setTitleColor(state == true ? LCZHexadecimalColor(hexadecimal: AppContentColor) : UIColor.white, for: .normal)
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
        
        // 扫码查询
        self.expressQueryView.sancButton.rx.tap.subscribe(onNext: { () in
            //设置扫码区域参数
            var style = LBXScanViewStyle()
            
            style.centerUpOffset = 60
            style.xScanRetangleOffset = 30
            
            if UIScreen.main.bounds.size.height <= 480 {
                //3.5inch 显示的扫码缩小
                style.centerUpOffset = 40
                style.xScanRetangleOffset = 20
            }
            
            style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
            
            style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
            style.photoframeLineW = 2.0
            style.photoframeAngleW = 16
            style.photoframeAngleH = 16
            
            style.isNeedShowRetangle = false
            
            style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
            style.animationImage = UIImage(named: "qrcode_scan_full_net")
            
            let vc = LBXScanViewController()
            vc.scanResultDelegate = self
            vc.scanStyle = style
            vc.arrayCodeType = [
                                AVMetadataObject.ObjectType.upce,
                                AVMetadataObject.ObjectType.ean8,
                                AVMetadataObject.ObjectType.ean13,
                                AVMetadataObject.ObjectType.itf14,
                                AVMetadataObject.ObjectType.interleaved2of5,
                                AVMetadataObject.ObjectType.aztec,
                                AVMetadataObject.ObjectType.pdf417,
                                AVMetadataObject.ObjectType.dataMatrix,
                                AVMetadataObject.ObjectType.qr,
                                AVMetadataObject.ObjectType.code39,
                                AVMetadataObject.ObjectType.code93,
                                AVMetadataObject.ObjectType.code128,
                                AVMetadataObject.ObjectType.code39Mod43
                               ]
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        
      
        
    }
    
    /// 删除指定的历史记录
    ///
    /// - Parameter sender: 当前按钮
    @objc func deleCellQuery(sender: UIButton) -> () {
        let cell = sender.LCZGetSuperView(superView: UITableViewCell.self)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = self.viewModel.getHistoryQuery()[indexPath.row] as? String
        self.viewModel.inquireExpressLogisticsInfo(number: number!).subscribe(onSuccess: { (model) in
            // 记录
            self.viewModel.storeHistoryQuery(text: self.expressQueryView.textField.text!)
            DispatchQueue.main.async(execute: {
                self.expressQueryView.tableView.reloadData()
               // self.navigationController?.hero.navigationAnimationType = .zoom
                diaryRoute.push("diary://homeEntrance/courierEntrance/expressQueryResults" ,context: [model,self.commonExpressCompaniesModel])
            })
        }, onError: { (error) in
        }).disposed(by: self.rx.disposeBag)
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
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: AppTitleColor)
        titleLabel.text = "历史查询"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}


extension ExpressQueryViewController: LBXScanViewControllerDelegate {
    
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        self.viewModel.inquireExpressLogisticsInfo(number: scanResult.strScanned!).subscribe(onSuccess: { (model) in
            // 记录
            self.viewModel.storeHistoryQuery(text: scanResult.strScanned!)
            DispatchQueue.main.async(execute: {
                self.expressQueryView.tableView.reloadData()
                diaryRoute.push("diary://homeEntrance/courierEntrance/expressQueryResults" ,context: [model,self.commonExpressCompaniesModel])
            })
        }, onError: { (error) in
        }).disposed(by: self.rx.disposeBag)
    }
}
