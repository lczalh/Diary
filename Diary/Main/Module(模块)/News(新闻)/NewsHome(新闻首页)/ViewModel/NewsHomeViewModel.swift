//
//  NewsHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeViewModel {
    
    // 表格数据序列
    let tableData = BehaviorRelay<[NewsListModel]>(value: [])
    
    // 停止头部刷新状态
    var endHeaderRefreshing: Driver<Bool>!
    
    // 停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool>!
    
    /// 当前页数
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
        
        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
        
        // 存储本地数据
        var models: Array<NewsListModel> = Array()
        
        // 查询当前类别的新闻数据
        input.currentCategory.subscribe(onNext: { (str) in
            self.currentCategory = str
            let items = realm.objects(NewsListModel.self).filter{ $0.category == str }
            for m in items {
                models.append(m)
            }
        }).disposed(by: dependency.disposeBag)
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{ _ -> SharedSequence<DriverSharingStrategy, [NewsListModel]> in //也可考虑使用flatMapFirst
                if models.count > 0, self.page == 0 { // 首次优先加载本地数据
                    self.page = 1;
                    return Observable.just(models).asDriver(onErrorJustReturn: [NewsListModel(JSON: ["publishTime":"","category":"","source":"","newsId":"","title":"","newsImg":""])!])
                } else {
                    self.page = 1;
                    return dependency.networkService.getNewsListData(category: self.currentCategory, page: self.page).asDriver(onErrorJustReturn: [NewsListModel(JSON: ["publishTime":"","category":"","source":"","newsId":"","title":"","newsImg":""])!]).map {
                        return self.dataHeavy(items: $0, realm: realm)
                    }

                }
        }

        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{ _ -> SharedSequence<DriverSharingStrategy, [NewsListModel]> in  //也可考虑使用flatMapFirst
                self.page += 1
                return dependency.networkService.getNewsListData(category: self.currentCategory, page: self.page).asDriver(onErrorJustReturn: [NewsListModel(JSON: ["publishTime":"","category":"","source":"","newsId":"","title":"","newsImg":""])!]).map {
                    return self.dataHeavy(items: $0, realm: realm)
                }
        }

        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }

        //生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            if items.count > 0 {
                self.tableData.accept(items + self.tableData.value)
            } else {
                LCZPrint("没有更多数据。。。。")
            }
        }).disposed(by: dependency.disposeBag)
        

        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            if items.count > 0 {
                self.tableData.accept(self.tableData.value + items)
            } else {
                LCZPrint("没有更多数据。。。。")
            }
        }).disposed(by: dependency.disposeBag)
    }
    
    
    /// 数据去重并移除空图片数据
    ///
    /// - Parameters:
    ///   - items: 模型数组
    ///   - realm: 数据库对象
    /// - Returns: 新数据数组
    func dataHeavy(items: Array<NewsListModel>, realm: Realm) -> Array<NewsListModel> {
        var modelAry: Array<NewsListModel> = Array()
        for m in items {
            let model = realm.objects(NewsListModel.self).filter{ $0.title == m.title }.first
            if model == nil, model?.newsImg?.isEmpty == false {
                try! realm.write {
                    realm.add(m)
                    modelAry.append(m)
                }
            }
        }
        return modelAry
    }
    
}
