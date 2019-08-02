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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LCZPublicHelper.shared.getTabbarHeight! + LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getNavigationHeight! + LCZPublicHelper.shared.getstatusBarHeight!, right: 0)
        tableView.register(CommonlyExpressTableViewCell.self, forCellReuseIdentifier: "CommonlyExpressTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
}
