//
//  FoodRecipeTypeListViewModel.swift
//  Diary
//
//  Created by linphone on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class  FoodRecipeTypeListViewModel {
    
    //布局flag false 一行一个商品 true 一行两个商品
    private var _btnFlagBool:Bool = false
    var btnFlagBool:Bool{
        get{
            return _btnFlagBool
        }
        set{
            _btnFlagBool = newValue
        }
    }
    
    //分页数
    private var _pageNum:Int = 0
    var pageNum:Int{
        get{
            return _pageNum
        }
        set{
            _pageNum = newValue
        }
    }
    
    //分类模型数组
    private var _typeFoodListModels:[FoodRecipeInfoListModel] = []
    var typeFoodListModels:[FoodRecipeInfoListModel] {
        get{
            return _typeFoodListModels
        }set{
            _typeFoodListModels = newValue
        }
    }
    
    //根据分类id获取数据
    public func getClassIdToFoodListInfoData(classId:String, result: @escaping (_ result: Swift.Result<[FoodRecipeInfoListModel], Swift.Error>) -> Void, disposeBag: DisposeBag)  {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getFoodPrcipeList(appkey: newHighSpeedDataAppKey, classid: classId, num: 20, start:pageNum)),
                        model: FoodRecipeInfoRootModel<FoodRecipeInfoResultModel>.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (model) in
                if model.status == 0 {
                    result(.success(model.result!.list as [FoodRecipeInfoListModel]))
                } else {
                    LCZProgressHUD.showError(title: model.msg)
                    result(.failure(DiaryRequestError.requestCodeError(message: model.msg)))
                }
            }, onError: { (error) in
                result(.failure(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            }).disposed(by: disposeBag)
    }
}
