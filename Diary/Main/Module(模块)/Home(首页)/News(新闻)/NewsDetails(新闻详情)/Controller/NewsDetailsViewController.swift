//
//  NewsDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsDetailsViewController: DiaryBaseViewController {
    
    /// 新闻模型
    public var model: SpeedNewsListModel?
    
    /// 父视图
    private var parentView: NewsDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentView = NewsDetailsView(frame: self.view.bounds)
        self.view.addSubview(self.parentView)
        
        let viewModel = NewsDetailsViewModel()
        
        self.parentView.webView.loadHTMLString(viewModel.jointHtml(model: model!), baseURL: nil)
        
        let enshrineButton = UIButton(type: .custom)
        getLastWindow()?.addSubview(enshrineButton)
        self.view.addSubview(enshrineButton)
        enshrineButton.setImage(UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), for: .normal)
        enshrineButton.setImage(UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal), for: .selected)
        enshrineButton.backgroundColor = UIColor.white
        enshrineButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-(LCZSafeAreaBottomHeight + 20))
            make.size.equalTo(50)
        }
        enshrineButton.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: enshrineButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 25, height: 25))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = enshrineButton.bounds
        shapeLayer.path = bezierPath.cgPath
        enshrineButton.layer.mask = shapeLayer
        
        let state = viewModel.verifyTheExistenceOfCollectionData(model: model!)
        
        if state {
            enshrineButton.isSelected = true
        } else {
            enshrineButton.isSelected = false
        }
        
//        var enshrineButton = UIButton(type: .custom)
//        if state { // 收藏
//            enshrineButton.setImage(UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal), for: .selected)
//            enshrineButton.isSelected = true
//        } else {
//            enshrineButton.setImage(UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), for: .normal)
//            enshrineButton.isSelected = false
//        }
//        
//        
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: enshrineButton)
//        
//        enshrineButton.rx.tap
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: {[weak self] () in
//                if viewModel.verifyTheExistenceOfCollectionData(model: self!.model!) { // 收藏则移除数据
//                    LCZProgressHUD.showSuccess(title: "已取消")
//                    // 切换按钮样式
//                    enshrineButton.isSelected = false
//                } else { // 未收藏则添加数据
//                    LCZProgressHUD.showSuccess(title: "已收藏")
//                    // 切换按钮样式
//                    enshrineButton.isSelected = true
//                }
//        }).disposed(by: rx.disposeBag)
    }
    
    

}
