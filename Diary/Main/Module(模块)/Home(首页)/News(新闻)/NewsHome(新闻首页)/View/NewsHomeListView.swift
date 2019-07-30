//
//  NewsHomeListView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsHomeListView: DiaryBaseView {

    public var tableView: UITableView!
    
    
    override func configUI() {
        tableView = UITableView(frame: self.bounds, style: .plain)
        //创建一个重用的单元格
        self.tableView!.register(NewsHomeCell.self, forCellReuseIdentifier: "NewsHomeCell")
        self.addSubview(tableView)
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.rowHeight = 110 * LCZSizeScale;
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LCZSafeAreaBottomHeight + LCZTabbarHeight, right: 0)
        tableView.isSkeletonable = true
        tableView.lcz_isUseComponent = true
        self.tableView.estimatedRowHeight = 0;
        
        self.tableView.estimatedSectionHeaderHeight = 0;
        
        self.tableView.estimatedSectionFooterHeight = 0;
        
    }

}

// MARK: - JXCategoryListContentViewDelegate
extension NewsHomeListView: JXCategoryListContentViewDelegate{
    
    func listView() -> UIView! {
        return self;
    }
}
