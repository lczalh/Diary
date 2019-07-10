//
//  SearchMovieNetworkMovie.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/5/7.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class SearchMovieNetworkService {
    
    public func getSearchMovieList(_ ac: String = "detail", pg: Int, wd: String) -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getSearchMovieList(ac: ac, pg: pg, wd: wd)), model: MovieHomeRootModel.self).subscribe(onSuccess: { (result) in
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
