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
        
        // 分享
        let shareBarButton = UIBarButtonItem(image: UIImage(named: "fenxiang")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = shareBarButton
        shareBarButton.rx.tap.subscribe(onNext: { () in
            LCZPublicHelper.shared.setNativeShare(title: self.model?.title, image: self.model?.pic, url: self.model!.url, result: { completed in
                if completed == true {
                    LCZProgressHUD.showSuccess(title: "分享成功")
                } else {
                    LCZProgressHUD.showError(title: "分享失败")
                }
            })
        }).disposed(by: rx.disposeBag)
        
        self.parentView = NewsDetailsView(frame: self.view.bounds)
        self.view.addSubview(self.parentView)
        
        let viewModel = NewsDetailsViewModel()
        
        self.parentView.webView.loadHTMLString(viewModel.jointHtml(model: model!), baseURL: nil)
        
        // 收藏按钮
        let enshrineButton = UIButton(type: .custom)
        LCZPublicHelper.shared.getLastWindow()!.addSubview(enshrineButton)
        self.view.addSubview(enshrineButton)
        enshrineButton.setImage(UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), for: .normal)
        enshrineButton.setImage(UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal), for: .selected)
        enshrineButton.backgroundColor = UIColor.white
        enshrineButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-(LCZPublicHelper.shared.getSafeAreaBottomHeight + 20))
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
       
        enshrineButton.rx.tap
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] () in
                let enshrineListJson = NSArray(contentsOfFile: viewModel.enshrineNewsPlist) // 读取本地数据
                var models: [SpeedNewsListModel]?
                if enshrineButton.isSelected == true {
                    models = Mapper<SpeedNewsListModel>().mapArray(JSONArray: enshrineListJson as! [[String : Any]]) // 转模型
                    // 拷贝数据
                    var newModels = models
                    for enshrineModel in models! {
                        // 移除已收藏的这条数据
                        if enshrineModel.title == self!.model!.title, enshrineModel.time == self!.model!.time { // 已收藏
                            newModels!.removeAll(enshrineModel)
                        }
                    }
                    (newModels!.toJSON() as NSArray).write(toFile: viewModel.enshrineNewsPlist, atomically: true)
                    // 移除本地数据 重新写入
                    LCZProgressHUD.showSuccess(title: "已取消")
                    // 切换按钮样式
                    enshrineButton.isSelected = false
                } else {
                    if enshrineListJson == nil {
                        models = []
                    } else {
                        models = Mapper<SpeedNewsListModel>().mapArray(JSONArray: enshrineListJson as! [[String : Any]]) // 转模型
                    }
                    // 写入数据
                    models?.append(self!.model!)
                    (models!.toJSON() as NSArray).write(toFile: viewModel.enshrineNewsPlist, atomically: true)
                    // 写入本地数据
                    LCZProgressHUD.showSuccess(title: "已收藏")
                    // 切换按钮样式
                    enshrineButton.isSelected = true
                }
        }).disposed(by: rx.disposeBag)
    }
    
   

}
