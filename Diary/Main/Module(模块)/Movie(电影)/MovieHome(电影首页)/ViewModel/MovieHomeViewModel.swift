//
//  MovieHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeViewModel {
    
    /// 列表数据
    var collectionData = BehaviorRelay<[MovieHomeModel]>(value: [])
    
    // 停止头部刷新状态
    var endHeaderRefreshing: Driver<Bool>!
    
    // 停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool>!
    
    /// 当前页数
    private var page: Int = 0
    
    
    init(input: (
            headerRefresh: Driver<Void>,
            footerRefresh: Driver<Void>),
         dependency: (
            disposeBag: DisposeBag,
            networkService: MovieHomeNetworkService,
            dataValidation: MovieHomeDataValidation)
        ) {
        
        // 获取下拉序列结果
        let headerRefreshData = input.headerRefresh
            .startWith(())
            .flatMapFirst { _ -> SharedSequence<DriverSharingStrategy, [MovieHomeModel]> in
                self.page = 1;
                return dependency.networkService.getMovieListData(pg: self.page).asDriver(onErrorJustReturn: Array<MovieHomeModel>())
//                    .map {
//                    return dependency.dataValidation.dataHeavy(items: $0, page: self.page)
//                }
        }
        
        // 获取上拉序列结果
        let footerRefreshData = input.footerRefresh
            .flatMapFirst { _ -> SharedSequence<DriverSharingStrategy, [MovieHomeModel]> in
                self.page += 1;
                return dependency.networkService.getMovieListData(pg: self.page).asDriver(onErrorJustReturn: Array<MovieHomeModel>())
//                    .map {
//                    return dependency.dataValidation.dataHeavy(items: $0, page: self.page)
//                }
        }
        
        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        //生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时 加载本地所有数据or新数据
        headerRefreshData.drive(onNext: { items in
            self.collectionData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            if items.count > 0 {
                // 加载数据
                self.collectionData.accept(self.collectionData.value + items)
            } else {
                LCZProgressHUD.showError(title: "哎呀！电影被您看完了！")
            }
        }).disposed(by: dependency.disposeBag)
        
        
    }
    
    
    
}
