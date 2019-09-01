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
        view.collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(dropDownRefresh))
        view.collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
        return view
    }()
    
    lazy var viewModel: MoreMoviesViewModel = {
        let vm = MoreMoviesViewModel()
        return vm
    }()
    
    private var models: Array<MovieHomeModel> = []
    /// 起始页数
    private var page: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "视频大全"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: cz_HexadecimalColor(hexadecimal: AppTitleColor)]
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = cz_HexadecimalColor(hexadecimal: AppContentColor)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        self.view.addSubview(moreMoviesView)
        
        reloadListData()

        self.moreMoviesView.collectionView.lcz_reloadClick = { [weak self] _ in
            self?.reloadListData()
        }
    }
    
    /// 首次加载 / 重新加载
    private func reloadListData() {
        // 占位图
        self.view.isSkeletonable = true
        self.moreMoviesView.collectionView.prepareSkeleton(completion: { done in
            self.view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),
                                                    animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        })
        
        self.viewModel.getMovieListData(pg: self.page).subscribe(onSuccess: { [weak self] (models) in
            self!.models += models
            DispatchQueue.main.async {
                self!.moreMoviesView.collectionView.reloadData()
                self!.view.hideSkeleton()
            }
        }) { [weak self] (error) in
            DispatchQueue.main.async(execute: {
                self!.view.hideSkeleton()
            })
        }.disposed(by: self.rx.disposeBag)
    }
    
    /// 下拉刷新
    @objc private func dropDownRefresh() {
        self.page = 2
        self.viewModel.getMovieListData(pg: self.page).subscribe(onSuccess: { [weak self] (models) in
            self!.models = models
            DispatchQueue.main.async {
                self!.moreMoviesView.collectionView.mj_header.endRefreshing()
                self!.moreMoviesView.collectionView.reloadData()
            }
        }) { [weak self] (error) in
            DispatchQueue.main.async(execute: {
                self!.moreMoviesView.collectionView.mj_header.endRefreshing()
            })
        }.disposed(by: rx.disposeBag)
    }
    
    /// 上拉刷新
    @objc private func pullToRefresh() {
        self.page += 1
        self.viewModel.getMovieListData(pg: self.page).subscribe(onSuccess: { [weak self] (models) in
            self!.models += models
            DispatchQueue.main.async {
                self!.moreMoviesView.collectionView.mj_footer.endRefreshing()
                self!.moreMoviesView.collectionView.reloadData()
            }
        }) { [weak self] (error) in
            DispatchQueue.main.async(execute: {
                self!.moreMoviesView.collectionView.mj_footer.endRefreshing()
            })
        }.disposed(by: rx.disposeBag)
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
