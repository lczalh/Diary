//
//  NewsHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeViewModel {
    
    // 栏目标题
    lazy var titles: Array<String> = {
         ["头条","社会","国内","国际","娱乐","体育","军事","科技","财经","时尚"]
    }()
    
    // 表格数据序列
    let tableData = BehaviorRelay<[NewsListModel]>(value: [])
    
    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    // 停止尾部刷新状态
    let endFooterRefreshing: Driver<Bool>
    
    init(input: (
            headerRefresh: Driver<Void>,
            footerRefresh: Driver<Void> ),
        dependency: (
            disposeBag: DisposeBag,
            networkService: NewsHomeNetworkService)
        ) {
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{ //也可考虑使用flatMapFirst
                return dependency.networkService.getNewsListData(category: "要闻").asDriver(onErrorJustReturn: [])
        }
        
        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.getNewsListData(category: "要闻").asDriver(onErrorJustReturn: [])
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
            self.tableData.accept(self.tableData.value + items )
        }).disposed(by: dependency.disposeBag)
        
    }
    

    
    
}
