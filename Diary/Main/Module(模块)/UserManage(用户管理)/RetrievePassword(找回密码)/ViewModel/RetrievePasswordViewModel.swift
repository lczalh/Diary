//
//  RetrievePasswordViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class RetrievePasswordViewModel {
    
    /// 找回密码
    ///
    /// - Parameters:
    ///   - to: 邮箱号
    ///   - user_pwd: 新密码
    ///   - user_pwd2: 确认新密码
    ///   - verify: 验证码
    ///   - code: 邮箱验证码
    /// - Returns: model
    public func retrievePassword(to: String, user_pwd: String, user_pwd2: String, verify: String, code: String) -> Single<LoginModel> {
        LCZProgressHUD.show(title: "正在找回密码")
        return Single<LoginModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.retrievePassword(ac: "email", to: to, user_pwd: user_pwd, user_pwd2: user_pwd2, verify: verify, code: code)), model: LoginModel.self).subscribe(onSuccess: { (result) in
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
    
    /// 获取验证码
    ///
    /// - Parameter to: 邮箱号
    /// - Returns: model
    public func geteMailCode(to: String) -> Single<LoginModel> {
        LCZProgressHUD.show(title: "正在获取")
        return Single<LoginModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.retrievePasswordSendVerificationCode(ac: "email", to: to)), model: LoginModel.self).subscribe(onSuccess: { (result) in
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
