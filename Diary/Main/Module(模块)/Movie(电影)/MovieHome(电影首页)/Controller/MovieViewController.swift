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
        self.movieHomeView = MovieHomeView(frame: self.view.bounds)
        self.view.addSubview(self.movieHomeView);
        
        let viewModel = MovieHomeViewModel()
        
        // 创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MovieHomeModel>>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieHomeCell", for: indexPath) as! MovieHomeCell
                cell.titleLabel.text = element.title
                return cell
        })
        
        viewModel.modelAry.map{
            [SectionModel(model: "", items: $0)]
        }.bind(to: self.movieHomeView.collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        // 同时获取索引和模型
        Observable.zip(self.movieHomeView.collectionView.rx.itemSelected, self.movieHomeView.collectionView.rx.modelSelected(MovieHomeModel.self))
            .bind { indexPath, item in
                diaryRoute.push("diary://movieHome/movieDetails" ,context: item)
            }.disposed(by: rx.disposeBag)

    
    }


}
