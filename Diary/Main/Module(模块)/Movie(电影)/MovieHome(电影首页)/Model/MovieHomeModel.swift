//
//  MovieHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct MovieHomeModel {
    var header: String
    var items: [Item]
}

extension MovieHomeModel : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MovieHomeModel, items: [Item]) {
        self = original
        self.items = items
    }
}
