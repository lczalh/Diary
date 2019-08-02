//
//  SearchNewsView.swift
//  Diary
//
//  Created by glgl on 2019/7/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchNewsView: DiaryBaseView {
    
    public var tableView: UITableView!
    
    override func configUI() {
        self.isSkeletonable = true
        tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.register(NewsHomeCell.self, forCellReuseIdentifier: "NewsHomeCell")
        tableView.rowHeight = 110 * LCZPublicHelper.shared.getScreenSizeScale;
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getNavigationHeight! + LCZPublicHelper.shared.getstatusBarHeight!, right: 0)
        tableView.isSkeletonable = true
        tableView.lcz_isUseComponent = true
        self.addSubview(self.tableView)
    }

}
