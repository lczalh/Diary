//
//  NewsMovieHomeViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieHomeViewController: DiaryBaseViewController {
    
    private var cellSectionsTitles: Array<Dictionary<String,String>> = [] as! Array<Dictionary<String,String>>
    
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
    
    /// cell模型数组
    private var cellModels: Array<Array<MovieHomeModel>> = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        // 搜索按钮
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "sousuo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        searchBarButtonItem.rx.tap.subscribe(onNext: { () in
            let nums = ["怒海潜沙", "陈情令", "美好时光", "斗罗大陆", "画江湖之不良人","雷霆沙赞","四目先生","明日之子"]
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
            searchViewController?.backButton.setImage(UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), for: .normal)
            searchViewController?.backButton.setTitle("", for: .normal)
            searchViewController?.navigationItem.backBarButtonItem = backBarButtonItem
            DispatchQueue.main.async(execute: {
                self.navigationController?.pushViewController(searchViewController!, animated: true)
            })
            
        }).disposed(by: rx.disposeBag)
        
        // 更多按钮
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "quanbugengduo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        moreBarButtonItem.rx.tap.subscribe(onNext: { () in
            diaryRoute.push("diary://homeEntrance/newsMovieHome/MoreMovies")
        }).disposed(by: rx.disposeBag)
        
        self.navigationItem.setRightBarButtonItems([searchBarButtonItem,moreBarButtonItem], animated: true)
        
        self.view.addSubview(newsMovieHomeContentView)
        
        getMovieListData()
        
        // 重新加载数据
        self.newsMovieHomeContentView.collectionView.lcz_reloadClick = { _ in
            self.getMovieListData()
        }

    }
    
    private func getMovieListData() {
        // 占位图
        view.isSkeletonable = true
        self.newsMovieHomeContentView.collectionView.prepareSkeleton(completion: { done in
            self.view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),
                                                   animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        })
        
        self.viewModel.getMovieListData().subscribe(onSuccess: { (models) in
            // 清空数据
            self.cellModels.removeAll()
            self.shufflingFigureModels.removeAll()
            if models.count > 0 {
                var todayHotMore: Array<MovieHomeModel> = []
                var guessYouLikeModels: Array<MovieHomeModel> = []
                var recommendToYouModels: Array<MovieHomeModel> = []
                var cinemaHitModels: Array<MovieHomeModel> = []
                for (index,model) in models.enumerated() {
                    // 轮播图数据
                    if index < 4 {
                        self.shufflingFigureModels.append(model)
                    }
                    // 今日推荐数据
                    if index >= 4 && index < 10 {
                        todayHotMore.append(model)
                    }
                    // 猜你在追数据
                    if index >= 10 && index < 16 {
                        guessYouLikeModels.append(model)
                    }
                    // 影院热映
                    if index >= 16 && index < 22 {
                        cinemaHitModels.append(model)
                    }
                    // 为你推荐数据
                    if index >= 22 {
                        recommendToYouModels.append(model)
                    }
                }
                self.cellModels.append(todayHotMore)
                self.cellModels.append(guessYouLikeModels)
                self.cellModels.append(cinemaHitModels)
                self.cellModels.append(recommendToYouModels)
                
                // 分组头数据
                self.cellSectionsTitles = [[
                                            "title":"今日精选",
                                            "image":"choiceness"
                                            ],
                                           [
                                            "title":"猜你在追",
                                            "image":"zhuizong"
                                            ],
                                           [
                                            "title":"影院热映",
                                            "image":"redu"
                                            ],
                                           [
                                            "title":"为你推荐",
                                            "image":"tuijian"
                                            ]]
                DispatchQueue.main.async(execute: {
                    self.newsMovieHomeContentView.collectionView.reloadData()
                    self.view.hideSkeleton()
                    // 刷新轮播图
                    let shufflingFigureHeaderView = self.newsMovieHomeContentView.LCZGetSubViews(subView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)
                    shufflingFigureHeaderView!.shufflingFigureView.fsPagerView.reloadData()
                })
            }
        }) { (error) in
            DispatchQueue.main.async(execute: {
                self.view.hideSkeleton()
            })
        }.disposed(by: rx.disposeBag)
    }

}

// MARK: - SkeletonCollectionViewDataSource
extension NewsMovieHomeViewController: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellModels.count == 0 ? 0 : self.cellModels[section].count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsMovieCollectionViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        if supplementaryViewIdentifierOfKind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                return "NewsMovieHomeShufflingFigureCollectionHeaderView"
            } else {
                return "NewsMovieHomeCollectionHeaderView"
            }
        } else {
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsMovieCollectionViewCell", for: indexPath) as! NewsMovieCollectionViewCell
        let model = self.cellModels[indexPath.section][indexPath.row]
        cell.imageView!.kf.indicatorType = .activity
        cell.imageView!.kf.setImage(with: ImageResource(downloadURL: URL(string: model.vod_pic!)!), placeholder: UIImage(named: "zanwutupian"))
        cell.titleLabel.text = model.vod_name
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeShufflingFigureCollectionHeaderView", for: indexPath) as! NewsMovieHomeShufflingFigureCollectionHeaderView
                let dict = self.cellSectionsTitles[indexPath.section]
                headerView.titleLabel.text = dict["title"]
                headerView.imageView.image = UIImage(named: dict["image"]!)
                headerView.shufflingFigureView.fsPagerView.dataSource = self
                headerView.shufflingFigureView.fsPagerView.delegate = self
                headerView.shufflingFigureView.fsPageControl.numberOfPages = self.shufflingFigureModels.count
                
                return headerView
            }else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeCollectionHeaderView", for: indexPath) as! NewsMovieHomeCollectionHeaderView
                let dict = self.cellSectionsTitles[indexPath.section]
                headerView.titleLabel.text = dict["title"]
                headerView.imageView.image = UIImage(named: dict["image"]!)
                return headerView
            }
            
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cellSectionsTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        guard self.cellModels.count == 0 else {
            let model = self.cellModels[indexPath.section][indexPath.row]
            diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: model)
            return
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsMovieHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: LCZWidth, height: 220 * LCZSizeScale)
        } else {
            return CGSize(width: LCZWidth, height: 30 * LCZSizeScale)
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
        cell.textLabel?.text = model.vod_name
        return cell
    }
    
}

// MARK: - FSPagerViewDelegate
extension NewsMovieHomeViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        let model = self.shufflingFigureModels[index]
        diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: model)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        let headerView = pagerView.LCZGetSuperView(superView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)!
        headerView.shufflingFigureView.fsPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        let headerView = pagerView.LCZGetSuperView(superView: NewsMovieHomeShufflingFigureCollectionHeaderView.self)!
        headerView.shufflingFigureView.fsPageControl.currentPage = pagerView.currentIndex
    }
    
    
}
