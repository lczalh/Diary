//
//  MoreMoviesViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MoreMoviesViewController: DiaryBaseViewController {
    
    lazy var moreMoviesView: MoreMoviesView = {
        let view = MoreMoviesView(frame: self.view.bounds)
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        return view
    }()
    
    lazy var viewModel: MoreMoviesViewModel = {
        let vm = MoreMoviesViewModel(headerRefresh: self.moreMoviesView.collectionView.mj_header.rx.refreshing.asDriver(), footerRefresh: self.moreMoviesView.collectionView.mj_footer.rx.refreshing.asDriver(), disposeBag: rx.disposeBag)
        return vm
    }()
    
    private var models: Array<MovieHomeModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "视频大全"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        self.view.addSubview(moreMoviesView)
        
        // 占位图
        view.isSkeletonable = true
        self.moreMoviesView.collectionView.prepareSkeleton(completion: { done in
            self.view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),
                                                   animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        })
        
        viewModel.collectionData.subscribe(onNext: {[weak self] (models) in
            if models.count > 0 {
                self!.models = models
                DispatchQueue.main.async {
                    self!.moreMoviesView.collectionView.reloadData({
                        self!.view.hideSkeleton()
                    })
                }
            }
        }).disposed(by: rx.disposeBag)
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(moreMoviesView.collectionView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(moreMoviesView.collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
    }
    

    

}

extension MoreMoviesViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MovieHomeCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieHomeCell", for: indexPath) as! MovieHomeCell
        let model = self.models[indexPath.row]
        if model.vod_pic?.isEmpty == false {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.vod_pic!)!), placeholder: UIImage(named: "zanwutupian"))
        }
        cell.titleLabel.text = model.vod_name
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.models.count == 0 else {
            let model = self.models[indexPath.row]
            diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: model)
            return
        }
    }
}

extension MoreMoviesViewController: SkeletonCollectionViewDelegate {
    
}
