//
//  NewsHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeListViewModel {
    
    // 表格数据序列
    let tableData = BehaviorRelay<[SpeedNewsListModel]>(value: [])
    
    // 停止头部刷新状态
    var endHeaderRefreshing: Driver<Bool>!
    
    // 停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool>!
    
    /// 当前数量
    private var page: Int = 0
    
    /// 当前分类
    private var currentCategory: String!
    
    init(input: (
            headerRefresh: Driver<Void>,
            footerRefresh: Driver<Void>,
            currentCategory: Observable<String>),
        dependency: (
            disposeBag: DisposeBag,
            networkService: NewsHomeNetworkService)
        ) {

        // 获取当前分类
        input.currentCategory.subscribe(onNext: { (str) in
            self.currentCategory = str
        }).disposed(by: dependency.disposeBag)
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{ _ -> SharedSequence<DriverSharingStrategy, [SpeedNewsListModel]> in //也可考虑使用flatMapFirst
                self.page = 0;
                return dependency.networkService.getNewsListData(channel: self.currentCategory, start: self.page).asDriver(onErrorJustReturn: Array<SpeedNewsListModel>())
        }

        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{ _ -> SharedSequence<DriverSharingStrategy, [SpeedNewsListModel]> in  //也可考虑使用flatMapFirst
                self.page += 20
                return dependency.networkService.getNewsListData(channel: self.currentCategory, start: self.page).asDriver(onErrorJustReturn: Array<SpeedNewsListModel>())
        }

        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }

        //生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            if items.count > 0 {
                self.tableData.accept(self.tableData.value + items)
            } else {
                LCZProgressHUD.showError(title: "哎呀！新闻被您看完了！")
            }
        }).disposed(by: dependency.disposeBag)
    }
    
}
