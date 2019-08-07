//
//  FunnyPicturesViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchFoodRecipeViewController: DiaryBaseViewController {
    ///搜索食物关键字
    public var searchFoodStr: String!
    
    lazy var searchFoodRecipeView:SearchOrTypeFoodRecipeView = {
        let newView = SearchOrTypeFoodRecipeView(frame: CGRect(x: 0, y:0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - (LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!)))
        newView.newCollectionView.delegate = self
        newView.newCollectionView.dataSource = self
        newView.newCollectionView.bounces = false
        newView.newCollectionView.isSkeletonable = true
        return newView
    }()
    
    lazy var vm:SearchFoodRecipeViewModel = {
        let newVM = SearchFoodRecipeViewModel()
        return newVM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(searchFoodStr ?? "")搜索详情"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(valueRGB: 0x57310C)]

        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = UIColor(valueRGB: 0xFECE1D)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 布局按钮
        let layoutBarButtonItem = UIBarButtonItem(image: UIImage(named: "quanbugengduo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        layoutBarButtonItem.rx.tap.subscribe(onNext: { () in
            self.vm.btnFlagBool = !self.vm.btnFlagBool
            self.searchFoodRecipeView.newCollectionView.reloadData()
//            diaryRoute.push("diary://homeEntrance/newsMovieHome/MoreMovies")
        }).disposed(by: rx.disposeBag)
        
        self.navigationItem.rightBarButtonItem = layoutBarButtonItem

        self.view.addSubview(searchFoodRecipeView)
        
        //获取搜索结果数据
        self.vm.getKeywordToFoodListInfoData(newKeyword:self.searchFoodStr, result: {[weak self] (result) in
            switch result {
            case .success(let value):
                self!.vm.searchFoodListModels = value
                self!.searchFoodRecipeView.newCollectionView.reloadData()
                self!.view.hideSkeleton()
                break
            case .failure(_):
                break
            }
            }, disposeBag: rx.disposeBag)
    }
    
    
    
    
}

extension SearchFoodRecipeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.vm.btnFlagBool == false{
            return CGSize(width:LCZPublicHelper.shared.getScreenWidth! - 26, height:125)
        }
        else{
            return CGSize(width:LCZPublicHelper.shared.getScreenWidth!/2 - 13 , height:220)
        }
    }
}

extension SearchFoodRecipeViewController:UICollectionViewDelegate , SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return FoodRecipeListCollectionViewCell.cellIdentifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.searchFoodListModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodRecipeListCollectionViewCell.cellIdentifier, for: indexPath) as! FoodRecipeListCollectionViewCell
        if self.vm.searchFoodListModels.count > 0 {
            let item = self.vm.searchFoodListModels[indexPath.row]
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
        let model = self.vm.searchFoodListModels[indexPath.row]
        diaryRoute.present("diary://homeEntrance/foodRecipeHome/foodRecipeDetail" ,context: model)
    }
    
    
}
