//
//  SettingViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SettingViewController: DiaryBaseViewController {
    
    lazy var settingView: SettingView = {
        let view = SettingView(frame: self.view.bounds)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: cz_HexadecimalColor(hexadecimal: AppTitleColor)]
        self.view.addSubview(settingView)
        
        // MARK: - 退出登陆事件
        self.settingView.loggedOutButton.rx.tap.subscribe(onNext: { () in
            DispatchQueue.main.async(execute: {
                UserDefaults.standard.removeObject(forKey: "account")
                UserDefaults.standard.removeObject(forKey: "password")
                LCZProgressHUD.showSuccess(title: "退出成功！")
                UIApplication.shared.delegate?.window??.rootViewController = UINavigationController(rootViewController: LoginViewController())
            })
        }).disposed(by: rx.disposeBag)
    }
    

    

}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClearCacheTableViewCell", for: indexPath) as! ClearCacheTableViewCell
        cell.titleLabel.text = "清除缓存"
        cell.cacheSizeLabel.text = cz_CacheSize
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cz_ClearCache()
            tableView.reloadData()
        }
    }
    
}




extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
