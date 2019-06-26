//
//  NewsMovieHomeViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieHomeViewController: DiaryBaseViewController {
    
    private var cellSectionsTitles: Array<String> = ["24小时热更榜","萨法撒","发顺丰"]
    
    lazy var newsMovieHomeContentView: NewsMovieHomeContentView = {
        let view = NewsMovieHomeContentView(frame: self.view.bounds)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        return view
    }()
    
    
    lazy var viewModel:NewsMovieHomeViewModel = {
        let vm = NewsMovieHomeViewModel()
        return vm
    }()
    
    /// 轮播图模型数组
    private var shufflingFigureModels: Array<MovieHomeModel> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(newsMovieHomeContentView)
        
        self.viewModel.getMovieListData(pg: 1, h: "24").subscribe(onSuccess: { (models) in
            for (index,model) in models.enumerated() {
                if index <= 6 {
                    self.shufflingFigureModels.append(model)
                }
            }
            DispatchQueue.main.async(execute: {
                self.newsMovieHomeContentView.collectionView.reloadData()
              //  self.newsMovieHomeContentView.collectionView.header
                let view = LCZGetSubViews(currentView: self.newsMovieHomeContentView.collectionView, subView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)
//                let view = self.newsMovieHomeContentView.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(index: 0)) as! NewsMovieHomeShufflingFigureCollectionHeaderView
                view!.shufflingFigureView.fsPagerView.reloadData()
            })
        }) { (error) in
            
        }.disposed(by: rx.disposeBag)
    }
    


}

// MARK: - SkeletonCollectionViewDataSource
extension NewsMovieHomeViewController: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsMovieCollectionViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsMovieCollectionViewCell", for: indexPath) as! NewsMovieCollectionViewCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeShufflingFigureCollectionHeaderView", for: indexPath) as! NewsMovieHomeShufflingFigureCollectionHeaderView
                headerView.titleLabel.text = self.cellSectionsTitles[indexPath.section]
                headerView.shufflingFigureView.fsPagerView.dataSource = self
                headerView.shufflingFigureView.fsPagerView.delegate = self
                headerView.shufflingFigureView.fsPageControl.numberOfPages = self.shufflingFigureModels.count
                return headerView
            }else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeCollectionHeaderView", for: indexPath) as! NewsMovieHomeCollectionHeaderView
                headerView.titleLabel.text = self.cellSectionsTitles[indexPath.section]
                return headerView
            }
            
        }
        return UICollectionReusableView()
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return self.cellSectionsTitles.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cellSectionsTitles.count
    }
    
 
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsMovieHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: LCZWidth, height: 220)
        } else {
            return CGSize(width: LCZWidth, height: 30)
        }
    }
}

extension NewsMovieHomeViewController: SkeletonCollectionViewDelegate {

}

// MARK: - 轮播图代理

// MARK: - FSPagerViewDataSource
extension NewsMovieHomeViewController: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.shufflingFigureModels.count;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let model = self.shufflingFigureModels[index]
        cell.imageView!.kf.indicatorType = .activity
        cell.imageView!.kf.setImage(with: ImageResource(downloadURL: URL(string: model.vod_pic!)!), placeholder: UIImage(named: "zanwutupian"))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension NewsMovieHomeViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        let headerView = LCZGetSuperView(currentView: pagerView, superView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)!
        headerView.shufflingFigureView.fsPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        let headerView = LCZGetSuperView(currentView: pagerView, superView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)!
        headerView.shufflingFigureView.fsPageControl.currentPage = pagerView.currentIndex
    }
}
