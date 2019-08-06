//
//  FoodRecipeHomeView.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeHomeView: DiaryBaseView {
    
    public var newTableView:UITableView!
    
    override func configUI() {
        self.backgroundColor = UIColor.white
        newTableView = UITableView(frame: CGRect(), style: .grouped)
        self.addSubview(newTableView)
        newTableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
        newTableView.register(FoodShufflingFigureTableViewCell.self, forCellReuseIdentifier: FoodShufflingFigureTableViewCell.cellIdentifier)
        newTableView.register(HotDishesTypeTableViewCell.self, forCellReuseIdentifier: HotDishesTypeTableViewCell.cellIdentifier)
        newTableView.register(FoodRecipeListTableViewCell.self, forCellReuseIdentifier: FoodRecipeListTableViewCell.cellIdentifier)
        
        newTableView.estimatedRowHeight = 120
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.sectionHeaderHeight = 45
        newTableView.sectionFooterHeight = 5
        newTableView.separatorStyle = .none
        newTableView.bounces = false
        newTableView.backgroundColor = UIColor.white
        newTableView.showsVerticalScrollIndicator = false
//        newTableView.isSkeletonable = true
        
    }
}
