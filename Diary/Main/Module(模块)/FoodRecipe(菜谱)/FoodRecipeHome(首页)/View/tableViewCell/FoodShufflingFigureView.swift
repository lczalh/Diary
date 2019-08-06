//
//  FoodShufflingFigureView.swift
//  Diary
//
//  Created by linphone on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodShufflingFigureTableViewCell: DiaryBaseTableViewCell {
//    fileprivate var titleLbl:UILabel = UILabel()
    var shufflingFigureItems: Array<FoodRecipeInfoListModel> = []
    public var fsPagerView: FSPagerView!
    
    public var fsPageControl: FSPageControl!
    
    static let cellIdentifier = "FoodShufflingFigureTableViewCellIdentifier"
    /// 轮播图样式
    private let shufflingFigureTransformerTypes: [FSPagerViewTransformerType] = [.crossFading,.zoomOut,.depth]
    
    override func config() {
        fsPagerView = FSPagerView()
        self.addSubview(fsPagerView)
        fsPagerView.snp.makeConstraints { (make) in
            make.height.equalTo(180)
            make.left.right.top.bottom.equalToSuperview()
        }
        fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "foodCellIdentifier")
        fsPagerView.layer.cornerRadius  = 7.5
        fsPagerView.layer.masksToBounds = true
        fsPagerView.itemSize = FSPagerView.automaticSize
        fsPagerView.automaticSlidingInterval = 2
        fsPagerView.isInfinite = !fsPagerView.isInfinite
        fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        fsPageControl = FSPageControl()
        fsPagerView.addSubview(fsPageControl)
        fsPageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        fsPageControl.contentHorizontalAlignment = .center
        fsPagerView.contentMode = .scaleAspectFill
        //设置下标指示器颜色（选中状态和普通状态）
        fsPageControl.setFillColor(UIColor(valueRGB: 0x57310C) , for: .normal)
        fsPageControl.setFillColor( UIColor(valueRGB: 0xFECE1D), for: .selected)
        // 随机轮播图样式
        let i = arc4random_uniform(3 - 0) + 0
        let type = shufflingFigureTransformerTypes[Int(i)]
        fsPagerView.transformer = FSPagerViewTransformer(type:type)
        fsPagerView.itemSize = FSPagerView.automaticSize
        fsPagerView.decelerationDistance = 1
        
        
        fsPagerView.delegate = self
        fsPagerView.dataSource = self
    }
    
    ///加载轮播图数据
    public func loadNewDataInfo(newItems:[FoodRecipeInfoListModel]){
        shufflingFigureItems = newItems
        fsPageControl.numberOfPages = shufflingFigureItems.count
        fsPagerView.reloadData()
    }
    
}

// MARK: - 轮播图代理

// MARK: - FSPagerViewDataSource
extension FoodShufflingFigureTableViewCell: FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return shufflingFigureItems.count;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "foodCellIdentifier", at: index)
        cell.imageView?.setImageWithURLString(shufflingFigureItems[index].pic!, placeholder: UIImage(named: "zanwutupian"))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    // MARK: - FSPagerViewDelegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        let model = shufflingFigureItems[index]
        diaryRoute.present("diary://homeEntrance/foodRecipeHome/foodRecipeDetail" ,context: model)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.fsPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.fsPageControl.currentPage = pagerView.currentIndex
    }
}
