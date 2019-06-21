//
//  RetrievePasswordViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class RetrievePasswordViewModel {
    
    public func retrievePassword(user_name: String, user_question: String, user_answer: String, user_pwd: String, user_pwd2: String, verify: String) -> Single<LoginModel> {
        LCZProgressHUD.show(title: "正在找回密码")
        return Single<LoginModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(MovieNetworkServices.retrievePassword(user_name: user_name, user_question: user_question, user_answer: user_answer, user_pwd: user_pwd, user_pwd2: user_pwd2, verify: verify)), model: LoginModel.self).subscribe(onSuccess: { (result) in
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
