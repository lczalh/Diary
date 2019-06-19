//
//  LoginViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    public func userLogin(username: String, password: String) -> Single<LoginModel> {
        LCZProgressHUD.show(title: "正在登陆")
        return Single<LoginModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.userLogin(user_name: username, user_pwd: password)), model: LoginModel.self).subscribe(onSuccess: { (result) in
                LCZProgressHUD.dismiss()
                if result.code == 1 {
                    single(.success(result))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                LCZProgressHUD.dismiss()
                single(.error(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            })
            return Disposables.create([request])
        })
    }
}
