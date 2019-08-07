//
//  FunnyPicturesViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeHomeViewController: DiaryBaseViewController {
    
    //主体界面
    lazy var foodRecipeHomeView:FoodRecipeHomeView = {
        let newView = FoodRecipeHomeView(frame:CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - (LCZPublicHelper.shared.getTabbarHeight! + LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!)))
        newView.newTableView.delegate = self
        newView.newTableView.dataSource = self
        
        return newView
    }()
    
    lazy var vm:FoodRecipeHomeViewModel = {
        let newVM = FoodRecipeHomeViewModel()
        return newVM
    }()
    
    // 重现statusBar相关方法
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = UIColor(valueRGB: 0xFECE1D) 
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        // 搜索按钮
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "sousuo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = searchBarButtonItem
        searchBarButtonItem.rx.tap.subscribe(onNext: { () in
            let nums = ["辣椒炒肉", "鱼香肉丝", "酸溜白菜", "酸辣土豆丝", "冬瓜排骨汤","爆炒牛肉","土豆炖鸡","红烧鱼"]
            let searchViewController = PYSearchViewController(hotSearches: nums, searchBarPlaceholder: NSLocalizedString("NSLocalizedString",value: "搜索菜谱", comment: ""), didSearch: { controller,searchBar,searchText in
                let searchFoodRecipeVC = SearchFoodRecipeViewController()
                searchFoodRecipeVC.hidesBottomBarWhenPushed = true
                searchFoodRecipeVC.searchFoodStr = searchText
                controller?.navigationController?.pushViewController(searchFoodRecipeVC, animated: true)
            })
            searchViewController!.hotSearchStyle = PYHotSearchStyle(rawValue: 4)!;
            searchViewController!.searchHistoryStyle = .default
            searchViewController!.searchViewControllerShowMode = .modePush
            searchViewController!.hidesBottomBarWhenPushed = true
            searchViewController?.backButton.setImage(UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), for: .normal)
            searchViewController?.backButton.setTitle("", for: .normal)
            searchViewController?.navigationItem.backBarButtonItem = backBarButtonItem
            DispatchQueue.main.async(execute: {
                self.navigationController?.pushViewController(searchViewController!, animated: true)
            })
            
        }).disposed(by: rx.disposeBag)

        self.view.addSubview(foodRecipeHomeView)
        //获取轮播图视图数据
        self.vm.getFoodInfoListData(newClassId: self.vm.foodClassId, newNum: 6, result: {[weak self] (result) in
            switch result {
            case .success(let value):
                self!.vm.foodRecommendModels = value
                self!.foodRecipeHomeView.newTableView.reloadData()
                break
            case .failure(_):
                break
            }
        }, disposeBag: rx.disposeBag)
        
        self.getThreeFoodInfoData()
   }
    
    //获得早中晚菜谱的列表模型数据
    func getThreeFoodInfoData(){
        self.vm.getFoodInfoListData(newClassId: self.vm.threeClassId, newNum: 10, result: {[weak self] (result) in
            switch result {
            case .success(let value):
                self!.vm.threeFoodListModels = value
                self!.foodRecipeHomeView.newTableView.reloadData()
                break
            case .failure(_):
                break
            }
            }, disposeBag: rx.disposeBag)
    }
}
extension FoodRecipeHomeViewController: SkeletonTableViewDataSource ,SkeletonTableViewDelegate{
//    SkeletonTableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.headTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newNum = section == 2 ? self.vm.threeFoodListModels.count : 1
        return newNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodShufflingFigureTableViewCell.cellIdentifier, for: indexPath) as! FoodShufflingFigureTableViewCell
               cell.loadNewDataInfo(newItems: self.vm.foodRecommendModels)
            return cell
        }
        else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDishesTypeTableViewCell.cellIdentifier, for: indexPath) as! HotDishesTypeTableViewCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodRecipeListTableViewCell.cellIdentifier, for: indexPath) as! FoodRecipeListTableViewCell
            if self.vm.threeFoodListModels.count > 0 {
              let item = self.vm.threeFoodListModels[indexPath.row]
                cell.foodImgV.setImageWithURLString(item.pic, placeholder:UIImage(named: "zanwutupian"))
                cell.foodNameLbl.text = item.name
                let newOneStr = item.content
                let newTwoStr = newOneStr?.replacingOccurrences(of: "<br />", with: "")
                cell.foodIntroduceLbl.text = newTwoStr
                cell.foodFlag.text = item.tag
            }
            //添加长按手势
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressGest(sender:)))
            cell.addGestureRecognizer(longPress)
            return cell
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let section = indexPath.section
        if section == 0 {
            return FoodShufflingFigureTableViewCell.cellIdentifier
        }
        else if section == 1 {
            return HotDishesTypeTableViewCell.cellIdentifier
        }
        else{
            return FoodRecipeListTableViewCell.cellIdentifier
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
           let newView = ThreeMeals0fSelectedView()
            newView.titleLbl.text = self.vm.headTitles[section]
            newView.newSegmentCon.selectedSegmentIndex = self.vm.threeSelectIndex
            newView.newSegmentCon.addTarget(self, action: #selector(newSegmentConClickMethod(newSegmentCon:)), for: .valueChanged)
           return newView
        }
        else{
            let newTitleLbl:UILabel = UILabel()
            newTitleLbl.text = self.vm.headTitles[section]
            newTitleLbl.textColor = UIColor(valueRGB: 0x57310C)
            newTitleLbl.font = LCZPublicHelper.shared.getBoldFont(size: 20)
            newTitleLbl.backgroundColor = UIColor.white
            return newTitleLbl
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        return nil
    }
    
//    SkeletonTableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let model = self.vm.threeFoodListModels[indexPath.row]
            diaryRoute.present("diary://homeEntrance/foodRecipeHome/foodRecipeDetail" ,context: model)
        }
       
    
    }
    
    //MARK: - 长按按钮点击响应事件
    @objc func cellLongPressGest(sender:UILongPressGestureRecognizer){
        
        let touchPoint = sender.location(in: self.foodRecipeHomeView.newTableView)
        var newIndex = ""
        if sender.state == UIGestureRecognizer.State.ended {
            let index = self.foodRecipeHomeView.newTableView.indexPathForRow(at: touchPoint)
            if index != nil {
                newIndex = "\(index![1])"
                let alertCon = UIAlertController(title:"长按", message: "你已经长按了\(newIndex)行", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
                let doneAction = UIAlertAction(title: "确定", style: .default ,handler: nil)
                cancelAction.setValue(UIColor.red, forKey:"titleTextColor")
                // 添加
                alertCon.addAction(cancelAction)
                alertCon.addAction(doneAction)
                // 弹出
                self.present(alertCon, animated: true, completion: nil)
            }
        }
       
    }
    
    //MARK: - 早中晚餐分段控件点击响应事件
    @objc func newSegmentConClickMethod(newSegmentCon:UISegmentedControl){
        self.vm.threeSelectIndex = newSegmentCon.selectedSegmentIndex
        self.vm.threeClassId = self.vm.threeClassIds[newSegmentCon.selectedSegmentIndex]
        self.getThreeFoodInfoData()
    }
    
}



