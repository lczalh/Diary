//
//  CopyrightStatementViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CopyrightStatementViewController: DiaryBaseViewController {
    
    lazy var copyrightStatementView: CopyrightStatementView = {
        let view = CopyrightStatementView(frame: self.view.bounds)
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
        view.contentLabel.attributedText = contentAttributedString
        view.contentLabel.layoutIfNeeded()
        view.scrollView.contentSize = CGSize(width: 0, height: view.contentLabel.frame.size.height + cz_NavigationHeight! + cz_StatusBarHeight!)
        return view
    }()
    
    lazy var viewModel: CopyrightStatementViewModel = {
        let vm = CopyrightStatementViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "版权声明"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: cz_HexadecimalColor(hexadecimal: AppTitleColor)]
        
        self.view.addSubview(copyrightStatementView)
        
    }

}
