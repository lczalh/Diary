//
//  Moay+Rx.swift
//  Diary
//
//  Created by 刘超正 on 2019/1/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

public extension Reactive where Base: MoyaProviderType {
    
    public func requestData<T: Mappable>(target: Base.Target, model: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        let response: Single<Response> = Single.create { [weak base] single in
            let cancellableToken = base?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        return Single<T>.create(subscribe: { (single) -> Disposable in
            let request = response.mapObject(T.self).subscribe(onSuccess: { (result) in
                single(.success(result))
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create([request])
        })
    }
}
