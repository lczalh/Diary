//
//  FoodTypeViewModel.swift
//  Diary
//
//  Created by linphone on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class FoodTypeViewModel{
    
    //选择的一级标签
    fileprivate var _oneSelectIndex:Int = 0
    var oneSelectIndex:Int{
        get{
            return self._oneSelectIndex
        }
        set{
            self._oneSelectIndex = newValue
        }
    }
    
    //选择的二级标签
    fileprivate var _twoSelectIndex:Int = -1
    var twoSelectIndex:Int{
        get{
            return self._twoSelectIndex
        }
        set{
            self._twoSelectIndex = newValue
        }
    }
    
    //获得一级标签数据
    private var _foodTypeResultItems:Array<FoodTypeResultModel> = []
    var foodTypeResultItems:Array<FoodTypeResultModel>{
        get{
            return _foodTypeResultItems
        }
        set{
            _foodTypeResultItems = newValue
        }
    }
    
    public func getFoodTypeResultIndexToItemInfo(index:Int)-> FoodTypeResultModel? {
        if  index >= 0 && index < _foodTypeResultItems.count {
            return _foodTypeResultItems[index]
        }
        return nil
    }
    
    //获得二级标签数据
    private var _foodTypeListItems:Array<FoodTypeListModel> = []
    var foodTypeListItems:Array<FoodTypeListModel>{
        get{
            return _foodTypeListItems
        }
    }
    
    
    //获得二级分类数组
    public func getFoodTypeListDataInfo(){
        if _foodTypeResultItems.count > 0 && oneSelectIndex >= 0  && oneSelectIndex < _foodTypeResultItems.count{
           _foodTypeListItems = _foodTypeResultItems[oneSelectIndex].list
        }
    }
    
    //二级标签模型
    public func getFoodTypeListIndexToItemInfo(index:Int)-> FoodTypeListModel? {
        if  index >= 0 && index < _foodTypeListItems.count {
            return _foodTypeListItems[index]
        }
        return nil
    }
    
    
    // 获取菜谱分类数据
    public func getFoodTypeListData(result: @escaping (_ result: Swift.Result<[FoodTypeResultModel], Swift.Error>) -> Void, disposeBag: DisposeBag)  {
        
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getFoodPrcipeTypeList(appkey: newHighSpeedDataAppKey)),
                        model: FoodTypeRootModel.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (model) in
                if model.status == 0 {
                    self._foodTypeResultItems = model.result!
                    self.getFoodTypeListDataInfo()
                    result(.success(model.result! as [FoodTypeResultModel]))
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
