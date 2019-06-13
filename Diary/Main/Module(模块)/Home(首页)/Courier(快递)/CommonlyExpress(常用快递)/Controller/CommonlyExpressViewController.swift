//
//  CommonlyExpressViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CommonlyExpressViewController: DiaryBaseViewController {
    
    lazy var commonlyExpressView: CommonlyExpressView = {
        let view = CommonlyExpressView(frame: self.view.bounds)
        view.tableView.dataSource = self
        return view
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonlyExpressTableViewCell", for: indexPath)
        return cell
    }
    
    
}
