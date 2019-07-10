//
//  MoreMoviesViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MoreMoviesViewModel {
    
    public var collectionData = BehaviorRelay<[MovieHomeModel]>(value: [])
    
    // 停止头部刷新状态
    var endHeaderRefreshing: Driver<Bool>!
    
    // 停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool>!
    
    private var page: Int = 2
    
    init(headerRefresh: Driver<Void>,
         footerRefresh: Driver<Void>,
         disposeBag: DisposeBag) {
        
       let headerRefreshData = headerRefresh.startWith(()).flatMapFirst { () -> SharedSequence<DriverSharingStrategy, [MovieHomeModel]> in
            self.page = 2
            return self.getMovieListData(pg: self.page).asDriver(onErrorJustReturn: Array<MovieHomeModel>())
        }
        
        let footerRefreshData = footerRefresh.flatMapFirst { () -> SharedSequence<DriverSharingStrategy, [MovieHomeModel]> in
            self.page += 1
            return self.getMovieListData(pg: self.page).asDriver(onErrorJustReturn: Array<MovieHomeModel>())
        }
        
        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        //生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时 加载新数据
        headerRefreshData.drive(onNext: { items in
            self.collectionData.accept(items)
        }).disposed(by: disposeBag)
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            if items.count > 0 {
                // 加载数据
                self.collectionData.accept(self.collectionData.value + items)
            } else {
                LCZProgressHUD.showError(title: "哎呀！电影被您看完了！")
            }
        }).disposed(by: disposeBag)
        
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
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }) { (error) in
                single(.error(error))
            }
            return Disposables.create([request])
        })
    }
}
