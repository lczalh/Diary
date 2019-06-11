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
    
    var headerImageView: UIImageView!
    
    override func configUI() {
        createTableView()
        createHeaderImageView()
    }
    
    /// tableview
    private func createTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: -(LCZNaviBarHeight + LCZStatusBarHeight), width: LCZWidth, height: LCZHeight + LCZNaviBarHeight + LCZStatusBarHeight), style: .grouped)
        self.addSubview(tableView)
        tableView.rowHeight = 50
        tableView.register(MineEntranceTableViewCell.self, forCellReuseIdentifier: "MineEntranceTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
    }
    
    private func createHeaderImageView() {
        headerImageView = UIImageView(frame: CGRect(x: 0, y: -200, width: LCZWidth, height: 200))
        tableView.addSubview(headerImageView)
        headerImageView.image = UIImage(named: "2")
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
    }
}
