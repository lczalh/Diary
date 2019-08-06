//
//  FunnyPicturesViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchFoodRecipeViewController: DiaryBaseViewController {
    
    public var movieName: String!
    
    lazy var searchFoodRecipeView:SearchFoodRecipeView = {
        let newView = SearchFoodRecipeView(frame: CGRect(x: 0, y:0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - (LCZPublicHelper.shared.getSafeAreaBottomHeight + LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!)))
        newView.newCollectionView.delegate = self
        newView.newCollectionView.dataSource = self
        return newView
    }()
    
    lazy var vm:SearchFoodRecipeViewModel = {
        let newVM = SearchFoodRecipeViewModel()
        return newVM
    }()
//
//    /// 模型数据
//    private var models: [MovieHomeModel] = []
//
//    private lazy var searchMovieView: SearchMovieView = {
//        let view = SearchMovieView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZStatusBarHeight - LCZNaviBarHeight - LCZSafeAreaBottomHeight))
//        view.tableView.dataSource = self
//        view.tableView.delegate = self
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索结果"
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

extension SearchFoodRecipeViewController:UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodRecipeListCollectionViewCell.cellIdentifier, for: indexPath) as! FoodRecipeListCollectionViewCell
        if self.vm.btnFlagBool == true{
            cell.twoListFoodLayout()
        }
        else{
            cell.oneListFoodLayout()
        }
        return cell
    }
    
    
}
