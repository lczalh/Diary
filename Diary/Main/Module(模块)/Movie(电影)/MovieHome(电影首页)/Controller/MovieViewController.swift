//
//  MovieViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieHomeViewController: DiaryBaseViewController {
    
    var movieHomeView: MovieHomeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "电影"
        // 修改导航栏按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 去掉返回按钮上的文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.movieHomeView = MovieHomeView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - LCZTabbarHeight - LCZSafeAreaBottomHeight))
        self.view.addSubview(self.movieHomeView);
        
        let viewModel = MovieHomeViewModel(input: (headerRefresh: self.movieHomeView.collectionView.mj_header.rx.refreshing.asDriver(),
                                                   footerRefresh: self.movieHomeView.collectionView.mj_footer.rx.refreshing.asDriver()),
                                           dependency: (disposeBag: rx.disposeBag,
                                                        networkService: MovieHomeNetworkService(),
                                                        dataValidation: MovieHomeDataValidation()))
        
        // 创建数据源
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, MovieHomeModel>>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieHomeCell", for: indexPath) as! MovieHomeCell
                if element.vod_pic?.isEmpty == false {
                    cell.imageView.kf.indicatorType = .activity
                    cell.imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: element.vod_pic!)!))
                }
                cell.titleLabel.text = element.vod_name
                return cell
        })
        
        viewModel.collectionData.map{
            [AnimatableSectionModel<String,MovieHomeModel>(model: "", items: $0)]
        }.bind(to: self.movieHomeView.collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(movieHomeView.collectionView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(movieHomeView.collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 同时获取索引和模型
        Observable.zip(self.movieHomeView.collectionView.rx.itemSelected, self.movieHomeView.collectionView.rx.modelSelected(MovieHomeModel.self))
            .bind { indexPath, item in
                diaryRoute.push("diary://movieHome/movieDetails" ,context: item)
            }.disposed(by: rx.disposeBag)
        
       
    }


}


