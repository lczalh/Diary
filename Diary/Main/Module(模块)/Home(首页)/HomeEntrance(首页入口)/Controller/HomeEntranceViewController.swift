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
        view.shufflingFigureView.fsPagerView.dataSource = self
        view.shufflingFigureView.fsPagerView.delegate = self
        view.shufflingFigureView.fsPageControl.numberOfPages = viewModel.shufflingFigureImage.count
        return view
    }()
    
    lazy var viewModel: HomeEntranceViewModel = {
        return HomeEntranceViewModel()
    }()
    
    // 重现statusBar相关方法
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        LCZPublicHelper.shared.setNavigationBarTransparency(navigationController: self.navigationController!)
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        LCZPublicHelper.shared.setRestoreTheTransparentNavigationBar(navigationController: self.navigationController!)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(homeEntranceView)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppContentColor)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 下载电视列表数据
        networkServicesProvider.request(MultiTarget(Resource.televisionJson)) { (result) in
            switch result {
            case .success(_):
                break;
            case .failure(_):
                break;
            }
        }

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
        cell.titleLabel.text = self.viewModel.cellTitles[indexPath.section][indexPath.row]
        cell.logoImageView.image = UIImage(named: self.viewModel.cellImages[indexPath.section][indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeEntranceCollectionHedderView", for: indexPath) as! HomeEntranceCollectionHedderView
            headerView.titleLabel.text = self.viewModel.sectionTitles[indexPath.section]
            headerView.logoImageView.image = UIImage(named: self.viewModel.sectionImages[indexPath.section]);
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = self.viewModel.cellTitles[indexPath.section][indexPath.row]
        if title == "快递" {
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                diaryRoute.present("diary://homeEntrance/courierEntrance")
            }, completion: nil)
        } else if title == "新闻" {
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                diaryRoute.present("diary://homeEntrance/newsEntranceTabBarController")
            }, completion: nil)
        } else if title == "视频" {
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                diaryRoute.present("diary://homeEntrance/movieEntrance")
            }, completion: nil)
        } else if title == "人脸识别" {
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                diaryRoute.push("diary://homeEntrance/faceRecognition")
            }, completion: nil)
        } else if title == "笑话" {
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                diaryRoute.present("diary://homeEntrance/jokeEntrance")
            }, completion: nil)
        }
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
       // cell.textLabel?.text = index.description+index.description
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
        self.homeEntranceView.shufflingFigureView.fsPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.homeEntranceView.shufflingFigureView.fsPageControl.currentPage = pagerView.currentIndex
    }
}

