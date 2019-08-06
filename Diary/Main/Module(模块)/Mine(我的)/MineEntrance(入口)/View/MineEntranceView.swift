//
//  MineEntranceView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MineEntranceView: DiaryBaseView {
    
    var tableView: UITableView!
    
    /// 图片
    var headerImageView: UIImageView!
    
    
    override func configUI() {
        createTableView()
        createHeaderImageView()
    }
    
    /// tableview
    private func createTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: -(LCZPublicHelper.shared.getNavigationHeight! + LCZPublicHelper.shared.getstatusBarHeight!), width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! + LCZPublicHelper.shared.getNavigationHeight! + LCZPublicHelper.shared.getstatusBarHeight!), style: .grouped)
        self.addSubview(tableView)
        tableView.rowHeight = 50 * LCZPublicHelper.shared.getScreenSizeScale
        tableView.register(MineEntranceTableViewCell.self, forCellReuseIdentifier: "MineEntranceTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 200 * LCZPublicHelper.shared.getScreenSizeScale, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = LCZPublicHelper.shared.getRgbColor(245, 245, 245, 1)
    }
    
    private func createHeaderImageView() {
        headerImageView = UIImageView(frame: CGRect(x: 0, y: -200 * LCZPublicHelper.shared.getScreenSizeScale, width: LCZPublicHelper.shared.getScreenWidth!, height: 200 * LCZPublicHelper.shared.getScreenSizeScale))
        tableView.addSubview(headerImageView)
        headerImageView.image = UIImage(named: "4")
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
    }
}
