//
//  CommonlyExpressViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CommonlyExpressViewController: DiaryBaseViewController {
    
    /// 快递公司模型
    public var commonExpressCompaniesModel: Array<CourierEntranceModel> = []
    
    lazy var commonlyExpressView: CommonlyExpressView = {
        let view = CommonlyExpressView(frame: self.view.bounds)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    lazy var viewModel: CommonlyExpressViewModel = {
        let vm = CommonlyExpressViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "常用快递"
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        self.view.addSubview(commonlyExpressView)
        
    }
    

}

extension CommonlyExpressViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commonExpressCompaniesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonlyExpressTableViewCell", for: indexPath) as! CommonlyExpressTableViewCell
        let model = self.commonExpressCompaniesModel[indexPath.row]
        if model.logo?.isEmpty == false {
            cell.logoImageView.kf.indicatorType = .activity
            cell.logoImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.logo!)!), placeholder: UIImage(named: "zanwutupian"))
        } else {
            cell.logoImageView.image = UIImage(named: "zanwutupian")
        }
        cell.titleLabel.text = model.name
        if model.tel?.isEmpty == false {
            cell.phoneNumber.text = "tel: \(model.tel!)"
            cell.rightImageView.isHidden = false
        } else {
            cell.phoneNumber.text = "暂无联系电话"
            cell.rightImageView.isHidden = true
        }
        return cell
    }
    
}

extension CommonlyExpressViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.commonExpressCompaniesModel[indexPath.row]
        if model.tel?.isEmpty == false {
            let phoneNumber = model.tel?.components(separatedBy: " ")
            UIApplication.shared.open(URL(string: "tel://\(phoneNumber![0])")!, options: [:], completionHandler: nil)
        } else {
            DispatchQueue.main.async {
                UIAlertController.showAlert(message: "暂无联系电话", in: self)
            }
        }
    }
}
