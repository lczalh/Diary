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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景不透明
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //重置导航栏背景
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "电影"
        // 去掉返回按钮上的文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        // 搜索按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: { () in
            let nums = ["流浪地球", "封神演义", "复仇者联盟", "斗罗大陆", "斗破苍穹","飞驰人生","新喜剧之王","家和万事惊"]
            let searchViewController = PYSearchViewController(hotSearches: nums, searchBarPlaceholder: NSLocalizedString("NSLocalizedString",value: "搜索电影", comment: ""), didSearch: { controller,searchBar,searchText in
                let searchMovieVC = SearchMovieViewController()
                searchMovieVC.hidesBottomBarWhenPushed = true
                searchMovieVC.movieName = searchText
                controller?.navigationController?.pushViewController(searchMovieVC, animated: true)
            })
            searchViewController!.hotSearchStyle = PYHotSearchStyle(rawValue: 4)!;
            searchViewController!.searchHistoryStyle = .default
            searchViewController!.searchViewControllerShowMode = .modePush
            searchViewController!.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(searchViewController!, animated: true)
            
        }).disposed(by: rx.disposeBag)
        
        self.movieHomeView = MovieHomeView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight))
        self.view.addSubview(self.movieHomeView);
        
        let viewModel = MovieHomeViewModel(input: (headerRefresh: self.movieHomeView.collectionView.mj_header.rx.refreshing.asDriver(),
                                                   footerRefresh: self.movieHomeView.collectionView.mj_footer.rx.refreshing.asDriver()),
                                           dependency: (disposeBag: rx.disposeBag,
                                                        networkService: MovieHomeNetworkService()))
        
        // 创建数据源
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, MovieHomeModel>>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieHomeCell", for: indexPath) as! MovieHomeCell
                if element.vod_pic?.isEmpty == false {
                    cell.imageView.kf.indicatorType = .activity
                    cell.imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: element.vod_pic!)!), placeholder: UIImage(named: "暂无图片"))
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
                diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: item)
            }.disposed(by: rx.disposeBag)
        
       
    }


}

extension MovieHomeViewController: PYSearchViewControllerDelegate {
    
}
