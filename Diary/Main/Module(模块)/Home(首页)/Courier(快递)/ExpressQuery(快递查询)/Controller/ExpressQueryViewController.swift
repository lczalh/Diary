//
//  LogisticsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ExpressQueryViewController: DiaryBaseViewController {
    
    lazy var expressQueryView: ExpressQueryView = {
        let view = ExpressQueryView(frame: self.view.bounds)
        return view
    }()
    
    lazy var viewModel: ExpressQueryViewModel = {
        return ExpressQueryViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(expressQueryView)
        // 标题
        self.tabBarController?.navigationItem.title = "快递查询"
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        // 返回
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.tabBarController?.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 监听文本框内容
        expressQueryView.textField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
                        .throttle(0.5) //在主线程中操作，0.3秒内值若多次改变，取最后一次
                        .map{$0.count > 0}
                        .drive(onNext: { (state) in
                            self.expressQueryView.inquireButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#57310C") : LCZHexadecimalColor(hexadecimal: "#bfbfbf")
                            self.expressQueryView.inquireButton.setTitleColor(state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : UIColor.white, for: .normal)
                            self.expressQueryView.inquireButton.isEnabled = state
                        })
                        .disposed(by: rx.disposeBag)
        
        // 查询按钮响应事件
        self.expressQueryView.inquireButton.rx.tap.debounce(0.3, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
//            diaryRoute.push("diary://homeEntrance/courierEntrance/expressQueryResults")
            self.expressQueryView.inquireButton.isEnabled = false
            self.viewModel.inquireExpressLogisticsInfo(number: "3711913697973").subscribe(onSuccess: { (model) in
                self.expressQueryView.inquireButton.isEnabled = true
                diaryRoute.push("diary://homeEntrance/courierEntrance/expressQueryResults" ,context: model)
            }, onError: { (error) in
                self.expressQueryView.inquireButton.isEnabled = true
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        
    }
    


}
