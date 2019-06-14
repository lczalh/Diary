//
//  LogisticsTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CourierEntranceTabBarController: UITabBarController {
    
    private var expressQueryViewController: ExpressQueryViewController = ExpressQueryViewController()
    
     private var commonlyExpressViewController: CommonlyExpressViewController = CommonlyExpressViewController()
    
    lazy var viewModel: CourierEntranceViewModel = {
        let vm = CourierEntranceViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCommonExpressCompaniesData().subscribe(onSuccess: { (models) in
            DispatchQueue.main.async {
                self.expressQueryViewController.commonExpressCompaniesModel = models
                self.commonlyExpressViewController.commonExpressCompaniesModel = models
            }
        }, onError: { (error) in
            
        }).disposed(by: rx.disposeBag)
        
        self.setTabBarItem(viewController: expressQueryViewController, tabBarTitle: "快递查询", image: UIImage(named: "huabanfubenhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "huabanfuben")?.withRenderingMode(.alwaysOriginal))
        self.setTabBarItem( viewController: commonlyExpressViewController, tabBarTitle: "常用快递", image: UIImage(named: "commonlyExpressAsh")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "commonlyExpress")?.withRenderingMode(.alwaysOriginal))
        
    }
    
    
    private func setTabBarItem(viewController: UIViewController?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        //改变文字颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#FECE1D")], for: .selected)
        self.addChild(viewController!)
        
    }
}
