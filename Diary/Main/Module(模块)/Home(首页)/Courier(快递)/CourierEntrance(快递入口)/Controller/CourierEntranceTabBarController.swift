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
        
        // 文件管理器
        let fileManger = FileManager.default
        
        // 优先使用本地常用快递公司数据。 没有则写入
        if fileManger.fileExists(atPath: viewModel.commonExpressCompaniesPlist) == true {
            let models = NSArray(contentsOfFile: viewModel.commonExpressCompaniesPlist)
            self.expressQueryViewController.commonExpressCompaniesModel = Mapper<CourierEntranceModel>().mapArray(JSONArray: models as! [[String : Any]])
            self.commonlyExpressViewController.commonExpressCompaniesModel = Mapper<CourierEntranceModel>().mapArray(JSONArray: models as! [[String : Any]])
        } else {
            viewModel.getCommonExpressCompaniesData().subscribe(onSuccess: { (models) in
                DispatchQueue.main.async {
                    // 存储数据
                    let commonExpressCompaniesAry = models.toJSON() as NSArray
                    commonExpressCompaniesAry.write(toFile: self.viewModel.commonExpressCompaniesPlist, atomically: true)
                    self.expressQueryViewController.commonExpressCompaniesModel = models
                    self.commonlyExpressViewController.commonExpressCompaniesModel = models
                }
            }, onError: { (error) in
                LCZPrint(error)
            }).disposed(by: rx.disposeBag)
        }
        
        
        
        self.setTabBarItem(viewController: expressQueryViewController, navigationTitle: "快递查询", tabBarTitle: "快递查询", image: UIImage(named: "huabanfubenhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "huabanfuben")?.withRenderingMode(.alwaysOriginal))
        self.setTabBarItem( viewController: commonlyExpressViewController, navigationTitle: "常用快递", tabBarTitle: "常用快递", image: UIImage(named: "commonlyExpressAsh")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "commonlyExpress")?.withRenderingMode(.alwaysOriginal))
        
    }
    
    
    private func setTabBarItem(viewController: UIViewController?, navigationTitle: String?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.navigationItem.title = navigationTitle
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        //改变文字颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#FECE1D")], for: .selected)
        let navigationController = UINavigationController(rootViewController: viewController!)
        // 修改导航颜色
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        self.addChild(navigationController)
        
    }
}
