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
                return self.getMovieListData(pg: 1).asDriver(onErrorJustReturn: [])
        }
        endHeaderRefreshing = headerRefreshData.map { _ in true }
    }
    
    /// 获取电影列表数据
    ///
    /// - Parameters:
    ///   - ac: detail
    ///   - pg: 页数
    /// - Returns: 数据
    private func getMovieListData(_ ac: String = "detail",pg: Int) -> Single<[MovieHomeModel]> {
        return Single<[MovieHomeModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.getMovieList(ac: ac, pg: pg)), model: MovieHomeRootModel.self).subscribe(onSuccess: { (result) in
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
