//
//  TelevisionViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionViewController: DiaryBaseViewController {
    
    var listContainerView: JXCategoryListContainerView!
    
    private lazy var televisionView: TelevisionView = {
        let view = TelevisionView(frame: self.view.bounds)
        view.categoryView!.delegate = self
        // 滚动控件
        listContainerView = JXCategoryListContainerView(delegate: self)
        listContainerView!.frame = CGRect(x: 0,
                                          y: 44,
                                          width: cz_ScreenWidth!,
                                          height: LCZPublicHelper.shared.getScreenHeight! - cz_NavigationHeight! - cz_StatusBarHeight! - 44)
        listContainerView!.defaultSelectedIndex = 0
        view.addSubview(listContainerView!)
        view.categoryView!.contentScrollView = listContainerView!.scrollView;
        return view
    }()
    
    private lazy var viewModel: TelevisionViewModel = {
        let vm = TelevisionViewModel()
        return vm
    }()
    
    private var models: TelevisionBaseModel?
    
    private var sectionModels: TelevisionSectionModel?
    
    /// 类别
    private var categorys: Array<String>? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(televisionView)
        let jsonString = try? String(contentsOf: resourcePath.appendingPathComponent("television.json"))

        self.models = TelevisionBaseModel(JSONString: jsonString!)
        for sectionModel in self.models!.list {
            categorys?.append(sectionModel.sectionTitle!)
        }
        televisionView.categoryView!.titles = categorys
    }
    

    

}

// MARK: - JXCategoryViewDelegate
extension TelevisionViewController: JXCategoryViewDelegate {

    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        self.listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: televisionView.categoryView!.selectedIndex)
    }

    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
        let listDict = self.listContainerView.validListDict as NSDictionary
        
        if let view  = listDict.object(forKey: (index)) as? TelevisionListView, let models = self.models?.list[index] {
            self.sectionModels = models
            view.collectionView.reloadData()
        }
    }

}

// MARK: - JXCategoryListContainerViewDelegate
extension TelevisionViewController: JXCategoryListContainerViewDelegate {

    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return categorys!.count
    }

    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        // 内容视图
        let televisionListView = TelevisionListView(frame:listContainerView.bounds)
        televisionListView.collectionView.dataSource = self
        televisionListView.collectionView.delegate = self
        listContainerView.didAppearPercent = 0.99
        self.sectionModels = self.models?.list[index]
        televisionListView.collectionView.reloadData()
        return (televisionListView as JXCategoryListContentViewDelegate)
    }



}

// MARK: - SkeletonCollectionViewDataSource
extension TelevisionViewController: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return (self.sectionModels?.cellList.count)!
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsMovieCollectionViewCell", for: indexPath) as! NewsMovieCollectionViewCell
        let cellModel = self.sectionModels?.cellList[indexPath.row]
        if cellModel?.image?.isEmpty == false {
            cell.imageView!.kf.indicatorType = .activity
            cell.imageView!.kf.setImage(with: ImageResource(downloadURL: URL(string: (cellModel?.image!)!)!), placeholder: UIImage(named: "zanwutupian"))
        } else {
            cell.imageView.image = UIImage(named: "zanwutupian")
        }
        
        cell.titleLabel.text = cellModel?.title
        return cell
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = self.sectionModels?.cellList[indexPath.row]
        if cellModel?.playUrl?.isEmpty == false {
            diaryRoute.push("diary://homeEntrance/televisionPlayer", context: cellModel)
        } else {
            LCZProgressHUD.showError(title: "暂无播放源")
        }
        
    }
    
}



extension TelevisionViewController: SkeletonCollectionViewDelegate {
    
}
