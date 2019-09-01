//
//  CommonlyExpressView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CommonlyExpressView: DiaryBaseView {
    
    public var tableView: UITableView!
    
    override func configUI() {
        createTableView()
    }
    
    private func createTableView() {
        tableView = UITableView(frame: self.bounds, style: .plain)
        self.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: cz_TabbarHeight! + cz_SafeAreaBottomHeight + cz_NavigationHeight! + cz_StatusBarHeight!, right: 0)
        tableView.register(CommonlyExpressTableViewCell.self, forCellReuseIdentifier: "CommonlyExpressTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
}
