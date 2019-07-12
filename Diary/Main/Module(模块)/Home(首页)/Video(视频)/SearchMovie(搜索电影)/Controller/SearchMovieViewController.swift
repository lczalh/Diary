//
//  SearchMovieViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/15.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchMovieViewController: DiaryBaseViewController {
    
    public var movieName: String!
    
    /// 模型数据
    private var models: [MovieHomeModel] = []
    
    private lazy var searchMovieView: SearchMovieView = {
        let view = SearchMovieView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZStatusBarHeight - LCZNaviBarHeight - LCZSafeAreaBottomHeight))
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索结果"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        self.view.addSubview(self.searchMovieView)
        
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        
        let viewModel = SearchMovieViewModel(input: (self.searchMovieView.tableView.mj_header.rx.refreshing.asDriver(),
                                                     self.searchMovieView.tableView.mj_footer.rx.refreshing.asDriver(),
                                                     self.movieName),
                                             dependency: (disposeBag: rx.disposeBag,
                                                          networkService: SearchMovieNetworkService())
                                            )
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.searchMovieView.tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)

        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(self.searchMovieView.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        viewModel.tableData.skip(1).subscribe(onNext: { (models) in
            self.models = models
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self.searchMovieView.tableView.reloadData()
                self.view.hideSkeleton()
            })
        }).disposed(by: rx.disposeBag)
        
        // 重新加载
        self.searchMovieView.tableView.lcz_reloadClick = { _ in
            DispatchQueue.main.async(execute: {
                self.searchMovieView.tableView.mj_header.beginRefreshing()
            })
        }
    }
    
    
    

}

extension SearchMovieViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as! SearchMovieCell
        if model.vod_pic?.isEmpty == false {
            cell.movieImageView.kf.indicatorType = .activity
            cell.movieImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.vod_pic!)!), placeholder: UIImage(named: "zanwutupian"))

        }
        cell.titleLabel.text = model.vod_name
        cell.detailsLabel.text = model.vod_blurb
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SearchMovieCell"
    }
    
    
}

extension SearchMovieViewController: SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.models.count == 0 else {
            let model = self.models[indexPath.row]
            diaryRoute.push("diary://homeEntrance/movieHome/movieDetails" ,context: model)
            return
        }
    }
}
