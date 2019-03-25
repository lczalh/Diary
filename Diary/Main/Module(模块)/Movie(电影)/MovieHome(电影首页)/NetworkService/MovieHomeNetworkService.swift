//
//  MovieHomeNetworkService.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeNetworkService {
    
    public func getMovieListData() -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getMovieList(ac: "detail")), model: MovieHomeRootModel.self).subscribe(onSuccess: { (result) in
                LCZPrint(result)
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
