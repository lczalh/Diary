//
//  LCZURLProtocol.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

//记录请求数量
var requestCount = 0

class LCZURLProtocol: URLProtocol , URLSessionDataDelegate, URLSessionTaskDelegate{
    
    //URLSession数据请求任务
    var dataTask:URLSessionDataTask?
    //url请求响应
    var urlResponse: URLResponse?
    //url请求获取到的数据
    var receivedData: NSMutableData?
    
    
    //判断这个 protocol 是否可以处理传入的 request
    override class func canInit(with request: URLRequest) -> Bool {
        //对于已处理过的请求则跳过，避免无限循环标签问题
        if URLProtocol.property(forKey: "MyURLProtocolHandledKey", in: request) != nil {
            return false
        }
        return true
    }
    
    //回规范化的请求（通常只要返回原来的请求就可以）
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //判断两个请求是否为同一个请求，如果为同一个请求那么就会使用缓存数据。
    //通常都是调用父类的该方法。我们也不许要特殊处理。
    override class func requestIsCacheEquivalent(_ aRequest: URLRequest,
                                                 to bRequest: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, to:bRequest)
    }
    
    //开始处理这个请求
    override func startLoading() {
        requestCount+=1
        print("Request请求\(requestCount): \(request.url!.absoluteString)")
        
        // 拦截播放页面
        
        let startIndex = String.Index.init(encodedOffset: request.url!.absoluteString.count - 5)
        let endIndex = String.Index.init(encodedOffset: request.url!.absoluteString.count)
        let lastStr = String(request.url!.absoluteString[startIndex..<endIndex])
        // 拦截真实播放地址
        if (lastStr.contains(".mp4")) || (lastStr.contains(".m3u8")) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "movieRealAddressNotification"), object: request.url!.absoluteString.components(separatedBy: CharacterSet(charactersIn: "="))[1])
        } else {
            //请求网络数据
            print("===== 从网络获取响应内容 =====")
            
            let newRequest = (self.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            //NSURLProtocol接口的setProperty()方法可以给URL请求添加自定义属性。
            //（这样把处理过的请求做个标记，下一次就不再处理了，避免无限循环请求）
            URLProtocol.setProperty(true, forKey: "MyURLProtocolHandledKey",
                                    in: newRequest)
            
            //使用URLSession从网络获取数据
            let defaultConfigObj = URLSessionConfiguration.default
            let defaultSession = Foundation.URLSession(configuration: defaultConfigObj,
                                                       delegate: self, delegateQueue: nil)
            self.dataTask = defaultSession.dataTask(with: self.request)
            self.dataTask!.resume()
        }
        
    }
    
    //结束处理这个请求
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }
    
    //URLSessionDataDelegate相关的代理方法
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        self.client?.urlProtocol(self, didReceive: response,
                                 cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        self.receivedData = NSMutableData()
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        self.receivedData?.append(data)
    }
    
    //URLSessionTaskDelegate相关的代理方法
    func urlSession(_ session: URLSession, task: URLSessionTask
        , didCompleteWithError error: Error?) {
        if error != nil {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    
}
