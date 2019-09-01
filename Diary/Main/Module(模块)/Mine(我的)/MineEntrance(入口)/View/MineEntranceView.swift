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
        tableView = UITableView(frame: CGRect(x: 0, y: -(cz_NavigationHeight! + cz_StatusBarHeight!), width: cz_ScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! + cz_NavigationHeight! + cz_StatusBarHeight!), style: .grouped)
        self.addSubview(tableView)
        tableView.rowHeight = 50 * cz_ScreenSizeScale
        tableView.register(MineEntranceTableViewCell.self, forCellReuseIdentifier: "MineEntranceTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 200 * cz_ScreenSizeScale, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = cz_RgbColor(245, 245, 245, 1)
    }
    
    private func createHeaderImageView() {
        headerImageView = UIImageView(frame: CGRect(x: 0, y: -200 * cz_ScreenSizeScale, width: cz_ScreenWidth!, height: 200 * cz_ScreenSizeScale))
        tableView.addSubview(headerImageView)
        headerImageView.image = UIImage(named: "1")
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
    }
}
