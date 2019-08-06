//
//  FoodCookingIngredientsView.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
//食材视图

import UIKit

class FoodCookingIngredientsView:  DiaryBaseView {
    var newTableView:UITableView!
    
    override func configUI() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        newTableView = UITableView(frame: CGRect(), style: .grouped)
        self.addSubview(newTableView)
        newTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        newTableView.separatorStyle = .none
        newTableView.register(FoodIngredientsTableViewCell.self, forCellReuseIdentifier: FoodIngredientsTableViewCell.cellIdentifier)
        newTableView.rowHeight = 45
        newTableView.sectionFooterHeight = 0.01
        newTableView.sectionHeaderHeight = 0.01
        newTableView.bounces = false
        newTableView.showsVerticalScrollIndicator = false
        newTableView.backgroundColor = UIColor.clear
    }
    
}
