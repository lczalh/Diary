//
//  FoodRecipeDetailView.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeDetailView: DiaryBaseView {
    
    var tableViewHeadView:UIView!
    
    var newTableView:UITableView!
    
    override func configUI() {
        self.backgroundColor = UIColor.clear
        tableViewHeadView  = UIView(frame: CGRect(x: 0, y:0, width: LCZPublicHelper.shared.getScreenWidth!, height: 240 - LCZPublicHelper.shared.getstatusBarHeight!))
        tableViewHeadView.backgroundColor = UIColor.clear
        
        newTableView = UITableView(frame: CGRect(), style: .grouped)
        self.addSubview(newTableView)
        newTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        newTableView.tableHeaderView = tableViewHeadView
        newTableView.separatorStyle = .none
        newTableView.layer.cornerRadius = 15
        newTableView.layer.masksToBounds = true
        newTableView.register(FoodDetailBasicInfoTableViewCell.self, forCellReuseIdentifier: FoodDetailBasicInfoTableViewCell.cellIdentifier)
        newTableView.register(FoodIngredientsTableViewCell.self, forCellReuseIdentifier: FoodIngredientsTableViewCell.cellIdentifier)
        newTableView.register(CookingProcessTableViewCell.self, forCellReuseIdentifier: CookingProcessTableViewCell.cellIdentifier)
        
        newTableView.estimatedRowHeight = 120 * LCZPublicHelper.shared.getScreenSizeScale;
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.sectionHeaderHeight = 45
        newTableView.sectionFooterHeight = 5
        newTableView.bounces = false
        newTableView.showsVerticalScrollIndicator = false
        newTableView.backgroundColor = UIColor.clear
        
    }
}
