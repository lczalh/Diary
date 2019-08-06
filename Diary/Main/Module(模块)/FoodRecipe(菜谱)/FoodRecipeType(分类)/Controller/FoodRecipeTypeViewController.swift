//
//  EnshrineJokeViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeTypeViewController: DiaryBaseViewController {
    
    //分类一级视图
    lazy var foodTypeOneView:FoodTypeOneView = {
        let oneView = FoodTypeOneView(frame: CGRect(x: 0, y:0, width:100, height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getTabbarHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight - LCZPublicHelper.shared.getstatusBarHeight! - LCZPublicHelper.shared.getNavigationHeight!))
        oneView.newCollectionView.delegate = self
        oneView.newCollectionView.dataSource = self
        return oneView
    }()
    
    //分类二级视图
    lazy var foodTypeTwoView:FoodTypeTwoView = {
        let twoView = FoodTypeTwoView(frame: CGRect(x: 100, y:5, width:LCZPublicHelper.shared.getScreenWidth! - 100, height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getTabbarHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight - LCZPublicHelper.shared.getstatusBarHeight! - LCZPublicHelper.shared.getNavigationHeight!))
        twoView.newCollectionView.delegate = self
        twoView.newCollectionView.dataSource = self
        return twoView
    }()
    
    lazy var vm:FoodTypeViewModel = {
        let newVM = FoodTypeViewModel()
        return newVM
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(foodTypeOneView)
        self.view.addSubview(foodTypeTwoView)
        self.vm.getFoodTypeListData()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: {[weak self] (items) in
               self?.vm.foodTypeResultItems = items
               self?.foodTypeOneView.newCollectionView.reloadData()
               self?.foodTypeTwoView.newCollectionView.reloadData()

            }) {[weak self] (error) in
                self?.foodTypeOneView.newCollectionView.reloadData()
                self?.foodTypeTwoView.newCollectionView.reloadData()

//                self?.foodTypeOneView.newCollectionView.reloadData()
            }.disposed(by: rx.disposeBag)
    }
}

extension FoodRecipeTypeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == foodTypeOneView.newCollectionView {
            return self.vm.foodTypeResultItems.count
        }
        else{
            return self.vm.foodTypeListItems.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == foodTypeOneView.newCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodTypeOneCollectionViewCell.cellIdentifier, for: indexPath) as! FoodTypeOneCollectionViewCell
                    let item = self.vm.getFoodTypeResultIndexToItemInfo(index: indexPath.row)
                    if item != nil{
                        cell.typeLbl.text = item?.name
                        let newFlag = self.vm.oneSelectIndex == indexPath.row ? true : false
                        cell.typeLbl.textColor = newFlag == true ? UIColor(valueRGB: 0x57310C) : UIColor(valueRGB: 0x000000)
                        cell.leftLineLbl.isHidden = !newFlag
                        cell.typeLbl.backgroundColor = newFlag == true ? UIColor(valueRGB: 0xffffff)  : UIColor.clear
                    }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodTypeTwoCollectionViewCell.cellIdentifier, for: indexPath) as! FoodTypeTwoCollectionViewCell
            let item = self.vm.getFoodTypeListIndexToItemInfo(index: indexPath.row)
            if item != nil{
                cell.typeLbl.text = item?.name
                let newFlag = self.vm.twoSelectIndex == indexPath.row ? true : false
                cell.typeLbl.textColor = newFlag == true ? UIColor(valueRGB: 0xffffff)  : UIColor(valueRGB: 0x000000)

                cell.typeLbl.backgroundColor = newFlag == true ? UIColor(valueRGB: 0x57310C)  : UIColor(valueRGB: 0xffffff)
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == foodTypeOneView.newCollectionView{
            self.vm.oneSelectIndex = indexPath.row
            self.vm.getFoodTypeListDataInfo()
            self.vm.twoSelectIndex = -1
            self.foodTypeOneView.newCollectionView.reloadData()
            self.foodTypeTwoView.newCollectionView.reloadData()
        }
        else{
            self.vm.twoSelectIndex = indexPath.row
            self.foodTypeTwoView.newCollectionView.reloadData()
        }
        
    }
}
