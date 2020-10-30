 //
//  HTTPDatas.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
 
 private let httpSharedInstance = HTTPDatas()
 
 // request method
 
 enum MethodType {
    case get
    case post
 }

class HTTPDatas: NSObject {

    // singlton
    class var sharedInstance: HTTPDatas {
        return httpSharedInstance
    }
}

 // https://is.snssdk.com
 // extension
 
 extension HTTPDatas
 {
    
    /// 网络哦请求通用版
    /// - Parameters:
    ///   - type: 数据请求方式
    ///   - URLString: 请求路径
    ///   - parameters: 请求参数
    ///   - finishCallBack: 成功后的回调
    func requetDatas(type:MethodType, URLString:String, parameters:[String:Any]? , finishCallBack: @escaping(_ json : JSON) -> (Void)) {
        // get request type
        let method = (type == .get ? HTTPMethod.get : HTTPMethod.post)
        
        // send request
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            // sucess or not
          
            guard response.result.value != nil else {
                print(response.result.error!)
                return
            }
            
            // get result
            guard response.result.isSuccess else {
                return
            }
            
            guard let dict = response.result.value else {
                return
            }
            
            // 将数据转为字典
            let json = JSON(dict)
            finishCallBack(json)
            
        }
    }
 }
