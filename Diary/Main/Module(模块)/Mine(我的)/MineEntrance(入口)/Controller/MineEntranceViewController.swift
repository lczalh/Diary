//
//  MineEntranceViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import MessageUI

class MineEntranceViewController: DiaryBaseViewController {
    
    // 重现statusBar相关方法
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    lazy var mineEntranceView: MineEntranceView = {
        let view = MineEntranceView(frame: self.view.bounds)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    lazy var mineEntranceViewModel: MineEntranceViewModel = {
       return MineEntranceViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mineEntranceView)
        
        // 返回
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 设置
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "shezhi")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = settingBarButtonItem
        settingBarButtonItem.rx.tap.subscribe(onNext: { () in
            diaryRoute.push("diary://mine/setting")
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - 邮件反馈
    private func emailFeedback() {
        //首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            let controller = MFMailComposeViewController()
            //设置代理
            controller.mailComposeDelegate = self
            //设置收件人
            controller.setToRecipients(["824092805@qq.com"])
            
            DispatchQueue.main.async {
                //打开界面
                self.present(controller, animated: true, completion: nil)
            }
        }else{
            LCZProgressHUD.showError(title: "当前设备尚未配置邮件帐号，请到邮件APP中添加您的邮箱后再使用此功能！")
        }
    }
    

}

extension MineEntranceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mineEntranceViewModel.cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mineEntranceViewModel.cellTitles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineEntranceTableViewCell", for: indexPath) as! MineEntranceTableViewCell
        cell.logoImageView.image = UIImage(named: self.mineEntranceViewModel.cellImages[indexPath.section][indexPath.row])
        cell.titleLabel.text = self.mineEntranceViewModel.cellTitles[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = self.mineEntranceViewModel.cellTitles[indexPath.section][indexPath.row]
        
        if title == "邮件反馈" {
            emailFeedback()
        } else if title == "去评分" {//1101649671
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id1472107585?action=write-review&mt=8")!, options: [:], completionHandler: nil)
        } else if title == "关于我们" {
            diaryRoute.push("diary://mine/aboutUs")
        } else if title == "版权声明" {
            diaryRoute.push("diary://mine/copyrightStatement")
        } else if title == "隐私政策" {
            diaryRoute.push("diary://mine/privacyPolicy")
        }
    }
    
}

extension MineEntranceViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY < -(200 + LCZNaviBarHeight + LCZStatusBarHeight) ) {
            var frame = self.mineEntranceView.headerImageView.frame
            frame.size.height =  -(offsetY + LCZNaviBarHeight + LCZStatusBarHeight) ;
            frame.origin.y = offsetY + LCZNaviBarHeight + LCZStatusBarHeight;
            self.mineEntranceView.headerImageView.frame = frame;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

extension MineEntranceViewController: MFMailComposeViewControllerDelegate {
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
