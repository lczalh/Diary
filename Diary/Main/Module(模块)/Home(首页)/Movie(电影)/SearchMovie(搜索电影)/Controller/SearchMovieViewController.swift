//
//  SearchMovieViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/15.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchMovieViewController: DiaryBaseViewController {
    
    public var movieName: String!
    
    private lazy var searchMovieView: SearchMovieView = {
        let view = SearchMovieView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZStatusBarHeight - LCZNaviBarHeight - LCZSafeAreaBottomHeight))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.movieName
        self.view.addSubview(self.searchMovieView)
        let viewModel = SearchMovieViewModel(input: (self.searchMovieView.tableView.mj_header.rx.refreshing.asDriver(),self.searchMovieView.tableView.mj_footer.rx.refreshing.asDriver(),self.movieName), dependency: (disposeBag: rx.disposeBag, networkService: SearchMovieNetworkService()))
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.searchMovieView.tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)

        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(self.searchMovieView.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)

        // 创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource
            <AnimatableSectionModel<String, MovieHomeModel>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as! SearchMovieCell
                if element.vod_pic?.isEmpty == false {
                    cell.movieImageView.kf.indicatorType = .activity
                    cell.movieImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: element.vod_pic!)!), placeholder: UIImage(named: "暂无图片"))
                    
                }
                cell.titleLabel.text = element.vod_name
                cell.detailsLabel.text = element.vod_blurb
                return cell
            })

        // 数据绑定
        viewModel.tableData.map {
            [AnimatableSectionModel(model: "", items: $0)]}
            .bind(to: self.searchMovieView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)

        // 同时获取索引和模型
        Observable.zip(self.searchMovieView.tableView.rx.itemSelected, self.searchMovieView.tableView.rx.modelSelected(MovieHomeModel.self))
            .bind { indexPath, item in
                diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: item)
            }.disposed(by: rx.disposeBag)
    }
    
    
    

}
