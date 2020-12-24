//
//  NetworkTools.swift
//  SwiftTest
//
//  Created by 许鹏程 on 2019/5/28.
//  Copyright © 2019 CDT-3. All rights reserved.
//

import UIKit
import Alamofire

//枚举
enum MehodType{
    case get
    case post
}

class NetworkTools {
    class func requestData(urlString : String, methodType : MehodType ,parameters : [String : String]? = nil,finishCallback : @escaping ( _ result : AnyObject) -> ()){
        let method : HTTPMethod
        switch methodType {
        case .get:
            method = .get   //走的2
            break
        default:
            method = .post
        }
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in   //走的3
//            print("网络异步加载数据")//走的5
            guard let result = response.result.value else{
                return
            }
//            print("block 执行完毕-----2")
            finishCallback(result as AnyObject)//走的6从这里断开
        }
        //这个方法走完走的4
//        print("走完该方法----1")
    }
}
