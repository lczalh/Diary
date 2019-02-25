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
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.addSubview(tableView)
        tableView.rowHeight = 200;
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
    }

}

// MARK: - JXCategoryListContentViewDelegate
extension NewsHomeListView: JXCategoryListContentViewDelegate{
    
    func listView() -> UIView! {
        return self;
    }
}
