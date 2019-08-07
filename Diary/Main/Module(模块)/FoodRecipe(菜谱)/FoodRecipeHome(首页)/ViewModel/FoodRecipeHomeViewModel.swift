//
//  FoodRecipeHomeViewModel.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class FoodRecipeHomeViewModel{
    
    init() {
        getRandomClassId()
    }
    
    //头部标签
    public var headTitles:Array<String> = ["美食推荐","热门菜品","三餐精选"]
    
   //美食推荐随机分类id数组依次为湘菜、上海菜 、海鲜、药膳、天津菜、东北菜
    public var foodClassIds:Array<String> = ["225","234","312","313","233","236"]
    
    //获得随机推荐id
    private func getRandomClassId(){
        // 随机样式
        let i = arc4random_uniform(6 - 0) + 0
        foodClassId = foodClassIds[Int(i)]
    }
    
    //美食推荐id
    var foodClassId:String = ""
    //美食推荐模型数组
    private var _foodRecommendModels:[FoodRecipeInfoListModel] = []
    var foodRecommendModels:[FoodRecipeInfoListModel] {
        get{
            return _foodRecommendModels
        }set{
            _foodRecommendModels = newValue
        }
    }
    
    
    ///分段控件选择
    public var threeSelectIndex:Int = 0
    //三餐选择的分类id依次为早、午、晚餐
    public var threeClassIds:Array<String> = ["562","563","565"]
    //默认选择早餐
    var threeClassId:String = "562"
    
    //三餐模型数组
    private var _threeFoodListModels:[FoodRecipeInfoListModel] = []
    var threeFoodListModels:[FoodRecipeInfoListModel] {
        get{
            return _threeFoodListModels
        }set{
            _threeFoodListModels = newValue
        }
    }
    
   
    // 根据类id获取菜谱数据
    public func getFoodInfoListData(newClassId: String, newNum: Int, result: @escaping (_ result: Swift.Result<[FoodRecipeInfoListModel], Swift.Error>) -> Void, disposeBag: DisposeBag)  {
        
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getFoodPrcipeList(appkey: newHighSpeedDataAppKey, classid: newClassId, num: newNum, start: 0)),
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
