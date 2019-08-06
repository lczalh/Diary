//
//  LogisticsTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CourierEntranceTabBarController: DiaryBaseTabBarController {
    
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
            
            }).disposed(by: rx.disposeBag)
        }
        
        
        
        self.LCZSetTabBarItem(viewController: expressQueryViewController, navigationTitle: "快递查询", tabBarTitle: "快递查询", image: UIImage(named: "huabanfubenhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "huabanfuben")?.withRenderingMode(.alwaysOriginal))
        self.LCZSetTabBarItem( viewController: commonlyExpressViewController, navigationTitle: "常用快递", tabBarTitle: "常用快递", image: UIImage(named: "commonlyExpressAsh")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "commonlyExpress")?.withRenderingMode(.alwaysOriginal))
        
    }
    
}
