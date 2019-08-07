//
//  CrossTalkViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeDetailViewController: DiaryBaseViewController {
    
    public var detailModel:FoodRecipeInfoListModel?
    //头部视图
    lazy var headFoodImgV:UIImageView = {
        let newImgV:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:LCZPublicHelper.shared.getScreenWidth!, height: 240))
        newImgV.kf.indicatorType = .activity
        newImgV.kf.setImage(with: ImageResource(downloadURL: URL(string: detailModel!.pic!)!), placeholder: UIImage(named: "zanwutupian"))
        return newImgV
    }()
    
    //导航视图
    lazy var foodNavigationView:FoodRecipeDetailNavigationView = {
        let newView = FoodRecipeDetailNavigationView(frame: CGRect(x: 0, y: LCZPublicHelper.shared.getstatusBarHeight!, width: LCZPublicHelper.shared.getScreenWidth!, height: 45))
        newView.backBtn.addTarget(self, action: #selector(backBtnClick(btn:)), for: .touchUpInside)
        newView.titleLbl.text = detailModel?.name
        return newView
    }()
    //详情视图
    lazy var foodDetailView:FoodRecipeDetailView = {
        let newView = FoodRecipeDetailView(frame: CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight))
        newView.newTableView.delegate = self
        newView.newTableView.dataSource = self
        return newView
    }()
    
    //烹饪模式视图
    lazy var cookingModelView:FoodingCookingModelView = {
        let newView = FoodingCookingModelView()
        return newView
    }()
    
    lazy var vm:FoodRecipeDetailViewModel = {
        let newVM = FoodRecipeDetailViewModel()
        return newVM
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.materialItems = detailModel!.material
        self.vm.processItems = detailModel!.process
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(headFoodImgV)
        self.view.addSubview(foodDetailView)
        self.view.addSubview(foodNavigationView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LCZPublicHelper.shared.setStatusBarBackgroundColor(color: UIColor.clear)
    }
    
    @objc func backBtnClick(btn:UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
}


// 单元格视图遵循的协议（）
extension FoodRecipeDetailViewController: UITableViewDataSource ,UITableViewDelegate{
    //    UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.headTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return self.vm.materialItems.count
        }
        else {
            return self.vm.processItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailBasicInfoTableViewCell.cellIdentifier, for: indexPath) as! FoodDetailBasicInfoTableViewCell
            if detailModel != nil{
                cell.foodNameLbl.text = "菜肴：\(detailModel?.name ?? "")"
                let newOneStr = detailModel?.content
                let newTwoStr = newOneStr?.replacingOccurrences(of: "<br />", with: "")
                cell.foodIntroduceLbl.text = "菜肴介绍：\(newTwoStr ?? "")"
                cell.cookingtimeLbl.text = "烹饪时间：\(detailModel?.cookingtime ?? "")"
                cell.peoplenumLbl.text = "用餐人数：\(detailModel?.peoplenum ?? "")"
                cell.foodFlag.text =  "标签：\(detailModel?.tag ?? "")"
            }
            return cell
        }
        else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodIngredientsTableViewCell.cellIdentifier, for: indexPath) as! FoodIngredientsTableViewCell
            if self.vm.materialItems.count > 0 {
                let item = self.vm.materialItems[indexPath.row]
                let typeStr = item.type == 1 ? "主" : "副"
                let typeColor = item.type == 1 ? UIColor.red : UIColor(valueRGB: 0xA4A5A7)
                cell.IngredientsNameLbl.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: item.mname!, oneTextFont: LCZPublicHelper.shared.getBoldFont(size: 16), oneTextColor: UIColor(valueRGB: 0x000000) , twoTextStr: "（\(typeStr)）", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 12), twoTextColor: typeColor)
                cell.IngredientsNumLbl.text = item.amount
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CookingProcessTableViewCell.cellIdentifier, for: indexPath) as! CookingProcessTableViewCell
            if self.vm.processItems.count > 0 {
                let item = self.vm.processItems[indexPath.row]
                cell.processDespLbl.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: "流程\(indexPath.row + 1)", oneTextFont: LCZPublicHelper.shared.getConventionFont(size: 22), oneTextColor: UIColor(valueRGB: 0x57310C), twoTextStr: "/\(self.vm.processItems.count)", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 15), twoTextColor: UIColor(valueRGB: 0xA4A5A8))
                let url = URL(string: item.pic!)
                cell.foodImgV.kf.setImage(with: url)
                let newOneStr = item.pcontent
                let newTwoStr = newOneStr?.replacingOccurrences(of: "<br />", with: "")
                cell.processContentLbl.text = newTwoStr
            }
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let newView = CookingHeadView()
            newView.titleLbl.text = self.vm.headTitles[section]
            newView.cookingBtn.addTarget(self, action: #selector(cookingModelBtnClick(btn:)), for: .touchUpInside)
            return newView
        }
        else{
            let newTitleLbl:UILabel = UILabel()
            newTitleLbl.text = self.vm.headTitles[section]
            newTitleLbl.textColor = UIColor(valueRGB: 0x57310C)
            newTitleLbl.font = LCZPublicHelper.shared.getBoldFont(size: 18)
            newTitleLbl.textAlignment = .center
            newTitleLbl.backgroundColor = UIColor.white
            return newTitleLbl
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let newLbl = UILabel()
        newLbl.backgroundColor = UIColor.white
        return newLbl
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        if point.y >= 240 - LCZPublicHelper.shared.getstatusBarHeight! {
            foodNavigationView.titleLbl.textColor = UIColor.black
            foodNavigationView.backgroundColor = UIColor.white
            LCZPublicHelper.shared.setStatusBarBackgroundColor(color: UIColor.white)
        }
        else if point.y > 240 - LCZPublicHelper.shared.getstatusBarHeight! - LCZPublicHelper.shared.getNavigationHeight! && point.y < 240 - LCZPublicHelper.shared.getstatusBarHeight!  {
            foodNavigationView.titleLbl.textColor = UIColor.clear
            foodNavigationView.backgroundColor = UIColor.clear
            LCZPublicHelper.shared.setStatusBarBackgroundColor(color: UIColor.clear)
        }
        else{
            foodNavigationView.titleLbl.textColor = UIColor.white
            foodNavigationView.backgroundColor = UIColor.clear
            LCZPublicHelper.shared.setStatusBarBackgroundColor(color: UIColor.clear)
        }
    }
    
    //MARK: - 烹饪模式按钮点击响应方法(点击进入烹饪模式)
    @objc func cookingModelBtnClick(btn:UIButton){
        self.view.window?.addSubview(cookingModelView)
        cookingModelView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
        cookingModelView.loadNewInfoDataToRefresh(newProcessModels: self.vm.processItems, newIngredientsModels: self.vm.materialItems)
    }
}
