//
//  SettingView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SettingView: DiaryBaseView {
    
    var tableView: UITableView!
    
    /// 退出登陆
    var loggedOutButton: UIButton!
    
    override func configUI() {
        tableView = UITableView(frame: self.frame, style: .plain)
        self.addSubview(tableView)
        tableView.register(ClearCacheTableViewCell.self, forCellReuseIdentifier: "ClearCacheTableViewCell")
        tableView.tableFooterView = createrTableFooterView()
        tableView.rowHeight = 50 * cz_ScreenSizeScale
        tableView.separatorStyle = .none
        tableView.backgroundColor = cz_RgbColor(245, 245, 245, 1)
    }
    
    private func createrTableFooterView() -> UIView {
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: cz_ScreenWidth!, height: 50 * cz_ScreenSizeScale))
        tableFooterView.backgroundColor = UIColor.white
        loggedOutButton = UIButton(type: .custom)
        tableFooterView.addSubview(loggedOutButton)
        loggedOutButton.setTitle("退出登陆", for: .normal)
        loggedOutButton.setTitleColor(UIColor.red, for: .normal)
        loggedOutButton.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        return tableFooterView
    }

}
