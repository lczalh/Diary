//
//  FoodRecipeTypeListViewController.swift
//  Diary
//
//  Created by linphone on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
// 分类菜谱列表界面

import UIKit

class FoodRecipeTypeListViewController:  DiaryBaseViewController {
    ///分类id
    public var classArr: Array<String>!
    
    lazy var typeFoodRecipeView:SearchOrTypeFoodRecipeView = {
        let newView = SearchOrTypeFoodRecipeView(frame: CGRect(x: 0, y:0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - (LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!)))
        //设置头部刷新控件
        newView.newCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(dropDownRefresh))
        newView.newCollectionView.mj_header.beginRefreshing()//开始刷新
        //设置尾部刷新控件
        newView.newCollectionView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
        newView.newCollectionView.delegate = self
        newView.newCollectionView.dataSource = self
//        newView.newCollectionView.isSkeletonable = true
        return newView
    }()
    
    lazy var vm:FoodRecipeTypeListViewModel = {
        let newVM = FoodRecipeTypeListViewModel()
        return newVM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(classArr[0])菜谱"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(valueRGB: 0x57310C)]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = UIColor(valueRGB: 0xFECE1D)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 布局按钮
        let layoutBarButtonItem = UIBarButtonItem(image: UIImage(named: "quanbugengduo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        layoutBarButtonItem.rx.tap.subscribe(onNext: { () in
            self.vm.btnFlagBool = !self.vm.btnFlagBool
            self.typeFoodRecipeView.newCollectionView.reloadData()
            //            diaryRoute.push("diary://homeEntrance/newsMovieHome/MoreMovies")
        }).disposed(by: rx.disposeBag)
        
        self.navigationItem.rightBarButtonItem = layoutBarButtonItem
        
        self.view.addSubview(typeFoodRecipeView)
        
    }
    
    
    /// 下拉刷新
    @objc private func dropDownRefresh() {
       
        self.vm.pageNum = 0
        self.vm.getClassIdToFoodListInfoData(classId: self.classArr[1],  result: {[weak self] (result) in
            switch result {
            case .success(let value):
                self!.vm.typeFoodListModels = value
                self!.typeFoodRecipeView.newCollectionView.mj_header.endRefreshing()
                self!.typeFoodRecipeView.newCollectionView.reloadData()
                self!.view.hideSkeleton()
                break
            case .failure(_):
                self!.typeFoodRecipeView.newCollectionView.mj_header.endRefreshing()
                self!.typeFoodRecipeView.newCollectionView.reloadData()
                break
            }
            }, disposeBag: rx.disposeBag)
    }
    
    /// 上拉刷新
    @objc private func pullToRefresh() {
       
        self.vm.pageNum += 20
        self.vm.getClassIdToFoodListInfoData(classId: self.classArr[1],  result: {[weak self] (result) in
            switch result {
            case .success(let value):
              if value.count > 0 {
                    for item in value {
                        self!.vm.typeFoodListModels.append(item)
                    }
                }
                self!.typeFoodRecipeView.newCollectionView.mj_footer.endRefreshing()
                self!.typeFoodRecipeView.newCollectionView.reloadData()
                self!.view.hideSkeleton()
                break
            case .failure(_):
                self!.typeFoodRecipeView.newCollectionView.mj_footer.endRefreshing()
                self!.typeFoodRecipeView.newCollectionView.reloadData()
                break
            }
            }, disposeBag: rx.disposeBag)
    }
    
}

extension FoodRecipeTypeListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.vm.btnFlagBool == false{
            return CGSize(width:LCZPublicHelper.shared.getScreenWidth! - 26, height:125)
        }
        else{
            return CGSize(width:LCZPublicHelper.shared.getScreenWidth!/2 - 13 , height:220)
        }
    }
}

extension FoodRecipeTypeListViewController:UICollectionViewDelegate , SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return FoodRecipeListCollectionViewCell.cellIdentifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.typeFoodListModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodRecipeListCollectionViewCell.cellIdentifier, for: indexPath) as! FoodRecipeListCollectionViewCell
        if self.vm.typeFoodListModels.count > 0 {
            let item = self.vm.typeFoodListModels[indexPath.row]
            cell.foodImgV.setImageWithURLString(item.pic, placeholder:UIImage(named: "zanwutupian"))
            cell.foodNameLbl.text = item.name
            let newOneStr = item.content
            let newTwoStr = newOneStr?.replacingOccurrences(of: "<br />", with: "")
            cell.foodIntroduceLbl.text = newTwoStr
            cell.foodFlag.text = item.tag
        }
        if self.vm.btnFlagBool == true{
            cell.twoListFoodLayout()
        }
        else{
            cell.oneListFoodLayout()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.vm.typeFoodListModels[indexPath.row]
        diaryRoute.present("diary://homeEntrance/foodRecipeHome/foodRecipeDetail" ,context: model)
    }
    
    
}
