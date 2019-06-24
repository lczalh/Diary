//
//  PrivacyPolicyViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: DiaryBaseViewController {
    
    lazy var privacyPolicyView: PrivacyPolicyView = {
        let view = PrivacyPolicyView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight))
        let contentParagraphStyle = NSMutableParagraphStyle()
        // 对齐方式
        contentParagraphStyle.alignment = .left
        // 首行缩进
        contentParagraphStyle.firstLineHeadIndent = view.contentLabel.font.pointSize * 2
        // 尾行缩进
        contentParagraphStyle.tailIndent = 0
        // 行间距
        contentParagraphStyle.lineSpacing = 2
        
        let contentAttributedString = NSAttributedString(string: self.viewModel.contentString, attributes: [NSAttributedString.Key.paragraphStyle : contentParagraphStyle])
//        let a = (self.viewModel.contentString as NSString).textSizeWithFont(font: LCZFontSize(size: 14), constrainedToSize: CGSize(width: LCZWidth, height: 100000))
//        LCZPrint(a);
        view.contentLabel.attributedText = contentAttributedString
        view.contentLabel.layoutIfNeeded()
        view.scrollView.contentSize = CGSize(width: 0, height: view.contentLabel.frame.height + LCZNaviBarHeight + LCZStatusBarHeight)
        return view
    }()
    
    lazy var viewModel: PrivacyPolicyViewModel = {
        let vm = PrivacyPolicyViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "隐私政策"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        self.view.addSubview(privacyPolicyView)
        
    }
    
    

}
