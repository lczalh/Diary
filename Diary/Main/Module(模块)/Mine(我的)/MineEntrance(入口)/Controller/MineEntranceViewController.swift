//
//  MineEntranceViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MineEntranceViewController: DiaryBaseViewController {
    
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
        
        
//        networkServicesProvider.rx.request(MultiTarget(MovieNetworkServices.problemFeedback(gbook_content: "1231", verify: "123"))).mapJSON().subscribe(onSuccess: { (res) in
//            LCZPrint(res)
//        }) { (error) in
//            
//        }
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
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                diaryRoute.push("diary://mine/problemfeedback")
            }
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
