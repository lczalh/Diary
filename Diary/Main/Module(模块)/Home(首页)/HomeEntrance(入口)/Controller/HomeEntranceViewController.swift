//
//  EntranceViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HomeEntranceViewController: DiaryBaseViewController {
    
    lazy var homeEntranceView: HomeEntranceView = {
        let view = HomeEntranceView(frame: self.view.bounds)
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.fsPagerView.dataSource = self
        view.fsPagerView.delegate = self
        view.fsPageControl.numberOfPages = viewModel.shufflingFigureImage.count
        return view
    }()
    
    lazy var viewModel: HomeEntranceViewModel = {
        return HomeEntranceViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(homeEntranceView)
        
    }
    

    

}

// MARK: - UICollectionViewDelegate
extension HomeEntranceViewController: UICollectionViewDelegate {
  
}

extension HomeEntranceViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cellTitles[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEntranceCollectionViewCell", for: indexPath) as! HomeEntranceCollectionViewCell
        cell.backgroundColor = UIColor.blue
        cell.titleLabel.text = self.viewModel.cellTitles[indexPath.section][indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeEntranceCollectionHedderView", for: indexPath) as! HomeEntranceCollectionHedderView
            headerView.titleLabel.text = self.viewModel.sectionTitles[indexPath.section]
            return headerView
        }
        return UICollectionReusableView()
    }
    
    
}

// MARK: - 轮播图代理

// MARK: - FSPagerViewDataSource
extension HomeEntranceViewController: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.shufflingFigureImage.count;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: viewModel.shufflingFigureImage[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension HomeEntranceViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.homeEntranceView.fsPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.homeEntranceView.fsPageControl.currentPage = pagerView.currentIndex
    }
}
