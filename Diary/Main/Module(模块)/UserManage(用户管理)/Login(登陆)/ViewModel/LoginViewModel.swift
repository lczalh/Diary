//
//  LoginViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    public func userLogin(username: String, password: String, result: @escaping (_ result: Swift.Result<LoginModel, Swift.Error>) -> Void, disposeBag: DisposeBag) {
        LCZProgressHUD.show(title: "正在登陆")
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(MovieNetworkServices.userLogin(user_name: username, user_pwd: password)),
                        model: LoginModel.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (model) in
                LCZProgressHUD.dismiss()
                if model.code == 1 {
                    result(.success(model))
                } else {
                    LCZProgressHUD.showError(title: model.msg)
                    result(.failure(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                LCZProgressHUD.dismiss()
                result(.failure(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            }).disposed(by: disposeBag)
    }
}
