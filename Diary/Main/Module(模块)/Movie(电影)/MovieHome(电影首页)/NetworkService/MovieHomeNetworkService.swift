//
//  MovieHomeNetworkService.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeNetworkService {
    
    public func getMovieListData(_ ac: String = "detail",pg: Int) -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getMovieList(ac: ac, pg: pg)), model: MovieHomeRootModel.self).debug().subscribe(onSuccess: { (result) in
                if result.code == 1 {
                    single(.success(result.list! as [MovieHomeModel]))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                }
            }) { (error) in
                LCZPrint(error)
                single(.error(error))
            }
            return Disposables.create([request])
        })
    }
    
}
