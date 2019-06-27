//
//  NewsMovieHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsMovieHomeViewModel {
    
    // 停止头部刷新状态
    public var endHeaderRefreshing: Driver<Bool>!
    
    /// 下拉数据
    public var headerRefreshData: SharedSequence<DriverSharingStrategy, Array<MovieHomeModel>>!
    
    init(headerRefresh: Driver<Void>) {
        headerRefreshData = headerRefresh.startWith(())
            .flatMapLatest { (models) -> SharedSequence<DriverSharingStrategy, Array<MovieHomeModel>> in
                return self.getMovieListData(pg: 1, h: "24").asDriver(onErrorJustReturn: [])
        }
        endHeaderRefreshing = headerRefreshData.map { _ in true }
    }
    
    public func getMovieListData(_ ac: String = "detail", pg: Int, h: String) -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getVideoToday(ac: ac, pg: pg, h: h)), model: MovieHomeRootModel.self).subscribe(onSuccess: { (result) in
                if result.code == 1 {
                    single(.success(result.list! as [MovieHomeModel]))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(MovieError.requestTimeout))
                }
            }) { (error) in
                single(.error(error))
            }
            return Disposables.create([request])
        })
    }
    
   
    
}
