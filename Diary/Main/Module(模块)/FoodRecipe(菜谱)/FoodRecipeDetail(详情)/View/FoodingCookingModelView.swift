//
//  FoodingCookingModelView.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
// 烹饪模式

import UIKit

class FoodingCookingModelView: DiaryBaseView {
    private var backgroundBtn:UIButton! //背景按钮
    private var normalView:UIView!
    private var titleLbl:UILabel! //标题
    var processModels:[FoodProcessListModel] = [] //流程模型数组
    var ingredientsModels:[FoodMaterialListModel] = [] //食材模型数组
    var newSegmentCon:UISegmentedControl! //流程、食材
    
    lazy var newProcessView:FoodCookingProcessView = {
        let newView = FoodCookingProcessView()
        newView.newPagerView.delegate = self
        newView.newPagerView.dataSource = self
        return newView
    }() //烹饪流程视图
    lazy var newIngredientsView:FoodCookingIngredientsView = {
        let newView = FoodCookingIngredientsView()
        newView.newTableView.delegate = self
        newView.newTableView.dataSource = self
        return newView
    }() //烹饪食材视图
    
    override func configUI() {
        self.backgroundColor = UIColor.py_color(withHexString: "#000000", alpha: 0.3)
        
        backgroundBtn = UIButton()
        self.addSubview(backgroundBtn)
        backgroundBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundBtn.addTarget(self, action: #selector(backgroundBtnClick(btn:)), for: .touchUpInside)
        
        normalView = UIView()
        self.addSubview(normalView)
        normalView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(350 * LCZPublicHelper.shared.getScreenSizeScale)
            make.height.equalTo(550 * LCZPublicHelper.shared.getScreenSizeScale)
        }
        normalView.backgroundColor = UIColor(valueRGB: 0xf7f8f9)
        normalView.layer.cornerRadius = 7.5
        normalView.layer.masksToBounds = true
        
        titleLbl = UILabel()
        normalView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        titleLbl.text = "烹饪模式"
        titleLbl.font = LCZPublicHelper.shared.getConventionFont(size: 18)
        titleLbl.textColor = UIColor(valueRGB: 0x57310C)
        titleLbl.backgroundColor = UIColor.white
        titleLbl.textAlignment = .center
        
        newSegmentCon = UISegmentedControl(items:["流程","食材"])
        newSegmentCon.selectedSegmentIndex = 0
        normalView.addSubview(newSegmentCon)
        newSegmentCon.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(25)
        }
        newSegmentCon.tintColor = UIColor(valueRGB: 0x57310C)
        newSegmentCon.addTarget(self, action: #selector(newSegmentConClickMethod(sender:)), for: .valueChanged)
        
        normalView.addSubview(newProcessView)
        newProcessView.snp.makeConstraints { (make) in
            make.top.equalTo(newSegmentCon.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        normalView.addSubview(newIngredientsView)
        newIngredientsView.snp.makeConstraints { (make) in
            make.top.equalTo(newSegmentCon.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        newIngredientsView.isHidden = true
        
    }
    
    //背景按钮点击响应方法
    @objc func backgroundBtnClick(btn:UIButton){
      self.removeFromSuperview()
    }
    
    //分段控件按钮点击响应方法
    @objc func newSegmentConClickMethod(sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            newIngredientsView.isHidden = true
            newProcessView.isHidden = false
        }
        else{
            newIngredientsView.isHidden = false
            newProcessView.isHidden = true
        }
    }
    
    ///获取烹饪流程数据信息并刷新视图
    public func loadNewInfoDataToRefresh(newProcessModels:[FoodProcessListModel],newIngredientsModels:[FoodMaterialListModel]){
        self.processModels = newProcessModels
        self.ingredientsModels = newIngredientsModels
        newProcessView.processNum.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: "\(1)", oneTextFont: LCZPublicHelper.shared.getConventionFont(size: 24), oneTextColor: UIColor(valueRGB: 0x57310C), twoTextStr: "/\(newProcessModels.count)", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 16), twoTextColor: UIColor(valueRGB: 0xA4A5A8))

        self.newIngredientsView.newTableView.reloadData()
        self.newProcessView.newPagerView.reloadData()
    }

}


// 单元格视图遵循的协议（）
extension FoodingCookingModelView: UITableViewDataSource ,UITableViewDelegate{
    //    UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ingredientsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodIngredientsTableViewCell.cellIdentifier, for: indexPath) as! FoodIngredientsTableViewCell
        if self.ingredientsModels.count > 0 {
            let item = self.ingredientsModels[indexPath.row]
            let typeStr = item.type == 1 ? "主" : "副"
            let typeColor = item.type == 1 ? UIColor.red : UIColor(valueRGB: 0xA4A5A7)
            cell.IngredientsNameLbl.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: item.mname!, oneTextFont: LCZPublicHelper.shared.getBoldFont(size: 16), oneTextColor: UIColor(valueRGB: 0x000000), twoTextStr: "(\(typeStr))", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 12), twoTextColor: typeColor)
            cell.IngredientsNumLbl.text = item.amount
            let newflag = indexPath.row == self.ingredientsModels.count - 1 ? true : false
            cell.lineLbl.isHidden = newflag
        }
        
        return cell
   }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newLbl = UILabel()
        newLbl.backgroundColor = UIColor.white
        return newLbl
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let newLbl = UILabel()
        newLbl.backgroundColor = UIColor.white
        return newLbl
    }

}

extension FoodingCookingModelView:FSPagerViewDelegate , FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.processModels.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FoodCookingProcessViewCellIdentifier", at: index)
        if self.processModels.count > 0 {
            let item = self.processModels[index]
            let processInfoView = CookingProcessInfoShowView()
            cell.addSubview(processInfoView)
            processInfoView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            let url = URL(string: item.pic!)
            processInfoView.processPicImgV.kf.setImage(with: url)
            let newOneStr = item.pcontent
            let newTwoStr = newOneStr?.replacingOccurrences(of: "<br />", with: "")
            processInfoView.processContentLbl.text = "\(index+1)/\(self.processModels.count)：\(newTwoStr ?? "")"
        }
        
        
        
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
         newProcessView.processNum.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: "\(pagerView.currentIndex + 1)", oneTextFont: LCZPublicHelper.shared.getConventionFont(size: 24), oneTextColor: UIColor(valueRGB: 0x57310C), twoTextStr: "/\(self.processModels.count)", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 16), twoTextColor: UIColor(valueRGB: 0xA4A5A8))
    }
}
