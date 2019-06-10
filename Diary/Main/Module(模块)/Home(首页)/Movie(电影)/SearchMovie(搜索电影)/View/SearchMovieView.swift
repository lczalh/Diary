//
//  SearchMovieView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/5/7.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchMovieView: DiaryBaseView {
    
    public var tableView: UITableView!

    override func configUI() {
       // self.backgroundColor = UIColor.purple
        tableView = UITableView(frame: self.bounds, style: .plain)
        self.addSubview(tableView)
        tableView.rowHeight = 120
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: "SearchMovieCell")
        //设置头部刷新控件
        tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        tableView.mj_footer = MJRefreshBackNormalFooter()
        tableView.separatorStyle = .none

    }

}
