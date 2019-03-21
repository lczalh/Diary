//
//  MovieHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct MovieHomeModel {
    var title: String!
    var url: String!
    var image: String!
    
    init(title: String, url: String, image: String) {
        self.title = title
        self.url = url
        self.image = image
    }
}
