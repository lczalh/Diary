//
//  ExpressQueryResultsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import CoreLocation

class ExpressQueryResultsViewController: DiaryBaseViewController {
    
    /// 物流详细信息
    public var model: ExpressQueryResultModel!
    
    lazy var expressQueryResultsView: ExpressQueryResultsView = {
        let view = ExpressQueryResultsView(frame: self.view.bounds)
        view.backgroundColor = LCZRgbColor(237, 234, 242, 1)
        view.tableView.dataSource = self as UITableViewDataSource
        view.courieNumberLabel.text = model.number
        view.courierCompanyLeabel.text = model.type
        // 计算耗时
        let initialTime = LCZTimeToTimeStamp(time: model.list[0].time!)
        let endTime = LCZTimeToTimeStamp(time: model.list[model.list.count-1].time!)
        let timeDifference = endTime - initialTime
        // 天
        let days = Int(abs(timeDifference / 3600 / 24))
        // 小时
        let hours = Int(abs((timeDifference / 3600).truncatingRemainder(dividingBy: 24.0)))
        view.timeConsumingLabel.text = "\(days)天\(hours)小时"
        return view
    }()
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(expressQueryResultsView)

        
        // 标题
        self.navigationItem.title = "快递详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        
        
    }

}

// MARK: - UITableViewDataSource
extension ExpressQueryResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpressQueryResultsTableViewCell", for: indexPath) as! ExpressQueryResultsTableViewCell
        let listModel = model!.list[indexPath.row] as ExpressQueryListModel
        cell.logisticsDetailsLabel.text = listModel.status
        cell.timeLabel.text = listModel.time
        // 设置第一条 颜色
        if indexPath.row == 0 {
            // 判断物流状态
            if model.deliverystatus == 3 { // 已签收
                cell.stateImageView.image = UIImage(named: "yiqianshou")
                cell.logisticsDetailsLabel.textColor = LCZHexadecimalColor(hexadecimal: "#3164E7")
            } else if model.deliverystatus == 4  {
                cell.stateImageView.image = UIImage(named: "qianshoushibai")
                cell.logisticsDetailsLabel.textColor = LCZHexadecimalColor(hexadecimal: "#d81e06")
            } else if model.deliverystatus == 2 {
                cell.stateImageView.image = UIImage(named: "paijiantixing")
                cell.logisticsDetailsLabel.textColor = LCZHexadecimalColor(hexadecimal: "#3164E7")
            } else if model.deliverystatus == 1 {
                cell.stateImageView.image = UIImage(named: "zaituzhong")
                cell.logisticsDetailsLabel.textColor = LCZHexadecimalColor(hexadecimal: "#3164E7")
            }
            
        } else {
            cell.logisticsDetailsLabel.textColor = LCZRgbColor(113, 112, 113, 1)
            cell.stateImageView.image = UIImage(named: "dangqiandizhi")
        }
        
        
        
        return cell
    }
    
    
}

