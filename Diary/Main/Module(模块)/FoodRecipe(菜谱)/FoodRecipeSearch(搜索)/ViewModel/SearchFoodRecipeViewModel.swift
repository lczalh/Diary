//
//  SearchFoodRecipeViewModel.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class  SearchFoodRecipeViewModel {

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
    
    //搜索模型数组
    private var _searchFoodListModels:[FoodRecipeInfoListModel] = []
    var searchFoodListModels:[FoodRecipeInfoListModel] {
        get{
            return _searchFoodListModels
        }set{
            _searchFoodListModels = newValue
        }
    }
    
    //根据搜索获取数据
    public func getKeywordToFoodListInfoData(newKeyword:String, result: @escaping (_ result: Swift.Result<[FoodRecipeInfoListModel], Swift.Error>) -> Void, disposeBag: DisposeBag)  {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.searchFoodPrcipe(appkey: newHighSpeedDataAppKey, keyword: newKeyword , num:20)),
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
