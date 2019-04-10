//
//  MovieDetailsModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/9.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation


class MovieDetailsModel: Object {
    var firstGroup: MovieDetailsFirstGroupModel?
}

// 第一组模型
class MovieDetailsFirstGroupModel: Object {
   
    
    
    
    
}


struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
