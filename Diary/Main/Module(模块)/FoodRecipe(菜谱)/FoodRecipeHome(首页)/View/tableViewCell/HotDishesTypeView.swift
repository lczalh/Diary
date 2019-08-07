//
//  HotDishesTypeView.swift
//  Diary
//
//  Created by linphone on 2019/7/30.
//  Copyright © 2019 lcz. All rights reserved.
// 热门菜品视图

import UIKit

class HotDishesTypeTableViewCell: DiaryBaseTableViewCell {
//    fileprivate var titleLbl:UILabel = UILabel()
    //热门菜品
    private var hotDishesItems:[[String:String]] = [["icon":"bangzhu","name":"家常菜","classid":"302"],["icon":"bangzhu","name":"私家菜","classid":"303"],["icon":"bangzhu","name":"快手菜","classid":"304"],["icon":"bangzhu","name":"农家菜","classid":"317"],["icon":"bangzhu","name":"湘菜","classid":"225"],["icon":"bangzhu","name":"川菜","classid":"224"],["icon":"bangzhu","name":"卤菜","classid":"315"],["icon":"bangzhu","name":"凉菜","classid":"306"]]
    public var newCollectionView:UICollectionView!
    static let cellIdentifier = "HotDishesTypeTableViewCellIdentifier"
    
    override func config() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:80 * LCZPublicHelper.shared.getScreenSizeScale, height: 65)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        newCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        self.addSubview(newCollectionView);
        newCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(135)
        }
        
        newCollectionView.showsVerticalScrollIndicator = false
        newCollectionView.bounces = false
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
        newCollectionView.backgroundColor = UIColor(valueRGB: 0xffffff)
        
        newCollectionView.register(HotDishesTypeCollectionViewCell.self, forCellWithReuseIdentifier: HotDishesTypeCollectionViewCell.cellIdentifier)
    }
    
}

extension HotDishesTypeTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return hotDishesItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotDishesTypeCollectionViewCell.cellIdentifier, for: indexPath) as! HotDishesTypeCollectionViewCell
        cell.typeIconImgV.image = UIImage(named: hotDishesItems[indexPath.row]["icon"]!)
        cell.typeTitleLbl.text = hotDishesItems[indexPath.row]["name"]!
        return cell
 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newArr:Array<String> = [hotDishesItems[indexPath.row]["name"]!,hotDishesItems[indexPath.row]["classid"]!]
        diaryRoute.push("diary://homeEntrance/foodRecipeHome/FoodRecipeTypeList" ,context: newArr)
    }
}
