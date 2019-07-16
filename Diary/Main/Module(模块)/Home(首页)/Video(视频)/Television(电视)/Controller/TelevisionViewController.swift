//
//  TelevisionViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionViewController: DiaryBaseViewController {
    
    lazy var televisionView: TelevisionView = {
        let view = TelevisionView(frame: self.view.bounds)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(televisionView)
    }
    

    

}

extension TelevisionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TelevisionCollectionViewCell", for: indexPath) as! TelevisionCollectionViewCell
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 5
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "NewsMovieHomeCollectionHeaderView", for: indexPath)
            headerView.backgroundColor = UIColor.red
            return headerView
        }
        return NewsMovieHomeCollectionHeaderView()
    }
}

extension TelevisionViewController: UICollectionViewDelegate {
    
}
