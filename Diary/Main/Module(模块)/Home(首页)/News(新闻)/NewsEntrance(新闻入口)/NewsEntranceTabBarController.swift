//
//  NewsEntranceTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsEntranceTabBarController: DiaryBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.LCZSetTabBarItem(viewController: NewsHomeViewController(), navigationTitle: "新闻", tabBarTitle: "新闻", image: UIImage(named: "bangzhuhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "bangzhu")?.withRenderingMode(.alwaysOriginal))
        
        let nums = ["怒海潜沙", "陈情令", "美好时光", "斗罗大陆", "画江湖之不良人","雷霆沙赞","四目先生","明日之子"]
        let searchViewController = PYSearchViewController(hotSearches: nums, searchBarPlaceholder: NSLocalizedString("NSLocalizedString",value: "搜索新闻", comment: ""), didSearch: { controller,searchBar,searchText in
            let searchNewsVC = SearchNewsViewController()
            searchNewsVC.hidesBottomBarWhenPushed = true
            searchNewsVC.searchContent = searchText
            controller?.navigationController?.pushViewController(searchNewsVC, animated: true)
        })
        searchViewController!.hotSearchStyle = PYHotSearchStyle(rawValue: 4)!;
        searchViewController!.searchHistoryStyle = .default
        searchViewController!.cancelButton.isHidden = true
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        searchViewController?.navigationItem.backBarButtonItem = backBarButtonItem
        // 搜索
        self.LCZSetTabBarItem(viewController: searchViewController, navigationTitle: "搜索", tabBarTitle: "搜索", image: UIImage(named: "sousuohui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "sousuo")?.withRenderingMode(.alwaysOriginal))
        // 收藏
        self.LCZSetTabBarItem(viewController: EnshrineNewsViewController(), navigationTitle: "收藏", tabBarTitle: "收藏", image: UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal))
    }

}
