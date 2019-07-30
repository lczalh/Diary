//
//  LCZPublicHelper.swift
//  Diary
//
//  Created by glgl on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import MessageUI
import Social

class LCZPublicHelper: NSObject {
    static let shared = LCZPublicHelper()
    private override init() {}
    
    /// 跳转到AppStore进行评分
    ///
    /// - Parameter appId: appId
    public func LCZAppStoreScore(appId: String) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8")!, options: [:], completionHandler: nil)
    }
    
    
    /// 调用系统发送邮件功能
    ///
    /// - Parameter recipients: 收件人
    public func LCZSendEmail(recipients: String) {
        //首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            let controller = MFMailComposeViewController()
            //设置代理
            controller.mailComposeDelegate = self
            //设置收件人
            controller.setToRecipients([recipients])
            
            DispatchQueue.main.async {
                LCZGetTopsideController()!.present(controller, animated: true, completion: nil)
            }
        }else{
            LCZProgressHUD.showError(title: "当前设备尚未配置邮件帐号，请到邮件APP中添加您的邮箱后再使用此功能！")
        }
    }
    
    
    
    
    
    /// 调用系统分享
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - url: 链接地址
    public func LCZNativeShare(title: String?, image: String?, url: String?) {
        var items: Array<Any> = []
        if (title == nil && image == nil && url == nil) {
            LCZProgressHUD.showError(title: "分享的数据为空")
            return
        }
        if (title != nil) {
            items.append(title as Any)
        }
        if (image != nil) {
            items.append(UIImage(named: image!) as Any)
        }
        if (url != nil)  {
            items.append(URL(string: url!) as Any)
        }
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        controller.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed == true {
                LCZProgressHUD.showSuccess(title: "分享成功")
            } else {
                LCZProgressHUD.showError(title: "分享失败")
            }
        }
        DispatchQueue.main.async {
            LCZGetTopsideController()!.present(controller, animated: true, completion: nil)
        }
    }
}


// MARK: - MFMailComposeViewControllerDelegate 系统邮件代理
extension LCZPublicHelper: MFMailComposeViewControllerDelegate {
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result{
        case .sent:
            LCZProgressHUD.showSuccess(title: "邮件发送成功")
        case .cancelled:
            LCZProgressHUD.showSuccess(title: "邮件取消成功")
        case .saved:
            LCZProgressHUD.showSuccess(title: "邮件保存成功")
        case .failed:
            LCZProgressHUD.showError(title: "邮件发送失败")
        }
    }
}
