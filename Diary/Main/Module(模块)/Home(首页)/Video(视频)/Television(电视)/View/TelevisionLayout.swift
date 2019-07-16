//
//  TelevisionLayout.swift
//  Diary
//
//  Created by glgl on 2019/7/16.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionLayout: UICollectionViewLayout {
    
    var n = 0
    
    // 准备方法被自动调用，以保证layout实例的正确
    override func prepare() {
        super.prepare()
    }
    
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.size.width - collectionView!.contentInset.left
            - collectionView!.contentInset.right
        var height: CGFloat = 0.0
        // 判断是否有多组
        if let sectionCount = collectionView?.numberOfSections {
            for i in 0..<sectionCount {
                height += CGFloat((collectionView!.numberOfItems(inSection: i) + 1) / 3) * (width / 3 * 2)
            }
        }
        return CGSize(width: width, height: height)
    }
    
    // 所有单元格位置、header/footer位置属性
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributesArray = [UICollectionViewLayoutAttributes]()

            // 判断是否有多组
            if let sectionCount = collectionView?.numberOfSections {
                for x in 0..<sectionCount {
                    let cellCount = self.collectionView!.numberOfItems(inSection: x)
                    attributesArray.append(self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item:0, section:x))!)
                    for i in 0..<cellCount {
                        let indexPath =  IndexPath(item:i, section:x)
                        let attributes =  self.layoutAttributesForItem(at: indexPath)
                        attributesArray.append(attributes!)
                    }
                }
            }
            
            
            
            return attributesArray
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            //返回对应于indexPath的位置的cell的布局属性
            let attribute =  UICollectionViewLayoutAttributes(forCellWith:indexPath)
            if indexPath.row == 0 {
                attribute.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 200)
            } else {
                if indexPath.row % 2 == 0 {
//                    attribute.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: CGFloat(150 * (indexPath.row / 2) + 250), width: UIScreen.main.bounds.width / 2, height: 150)
    
                } else {
                    n += 1
                    attribute.frame = CGRect(x: 0, y: 150 * (n - 1) + 250, width: Int(UIScreen.main.bounds.width / 2), height: 150)
                }
            }

            return attribute
    }
    //当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        n = 0
        return true
    }
    
    //返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载 header footer
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //返回对应于indexPath的位置的header/footer的布局属性
        let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
        attribute.frame = CGRect(x:0, y:0,
                                 width:200,
                                 height:50)
       // attributesArray.append(attribute)
        return attribute
    }
    
}
