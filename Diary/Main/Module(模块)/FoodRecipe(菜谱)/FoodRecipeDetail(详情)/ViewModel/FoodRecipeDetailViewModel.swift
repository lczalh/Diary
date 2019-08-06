//
//  FoodRecipeDetailViewModel.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation


class FoodRecipeDetailViewModel {
    
    //头部标签
    public var headTitles:Array<String> = ["美食简介","制作食材","烹饪流程"]
    
    
    //获得制作食材模型数组
    private var _materialItems:[FoodMaterialListModel] = []
    var materialItems:[FoodMaterialListModel]{
        get{
            return _materialItems
        }
        set{
           _materialItems = newValue
        }
    }
    
    //获得制作流程模型数组
    private var _processItems:[FoodProcessListModel] = []
    var processItems:[FoodProcessListModel]{
        get{
            return _processItems
        }
        set{
            _processItems = newValue
        }
    }
    
}

