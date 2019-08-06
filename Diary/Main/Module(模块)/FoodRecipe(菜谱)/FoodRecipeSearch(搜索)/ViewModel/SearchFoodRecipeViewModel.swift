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
}
