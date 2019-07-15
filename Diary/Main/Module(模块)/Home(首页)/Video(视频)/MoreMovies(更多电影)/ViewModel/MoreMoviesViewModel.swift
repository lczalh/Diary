//
//  MoreMoviesViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MoreMoviesViewModel {
    
    /// 获取电影列表数据
    ///
    /// - Parameters:
    ///   - ac: detail
    ///   - pg: 页数
    /// - Returns: 数据
    public func getMovieListData(_ ac: String = "detail",pg: Int) -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getMovieList(ac: ac, pg: pg)), model: MovieHomeRootModel.self).subscribe(onSuccess: { (result) in
                if result.code == 1 {
                    single(.success(result.list! as [MovieHomeModel]))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }) { (error) in
                single(.error(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            }
            return Disposables.create([request])
        })
    }
}
