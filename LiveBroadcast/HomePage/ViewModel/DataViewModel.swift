//
//  DataViewModel.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/5/28.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit
import Alamofire
class DataViewModel {
//    lazy var anchorGroups : [AnchorGroup]
    //热门
    lazy var oneGroup : AnchorGroup = AnchorGroup()
    //颜值
    lazy var twoGroup : AnchorGroup = AnchorGroup()
    //游戏
    lazy var threeGroup : [AnchorGroup] = [AnchorGroup]()
}

extension DataViewModel{
    //请求所有数据
    func resquestData(finishCallback : @escaping () -> ()){
        let parameter = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
//       请求第一部分推荐数据
        let netGroup = DispatchGroup()
        netGroup.enter()
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", methodType: .get, parameters: ["time" : NSDate.getCurrentTime()]) { (response) in
            guard let responseDic = response as? [String : AnyObject] else { return }
            guard let responseArr = responseDic["data"] as? [[String : AnyObject]] else { return }
            self.oneGroup.tag_name = "热门"
            self.oneGroup.icon_url = "home_header_hot"

            for dict in responseArr{
                let group = AnchorModel(dict: dict)
                self.oneGroup.anchors.append(group)
            }
            netGroup.leave()
        }
        
        // 颜值数据
        netGroup.enter()
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", methodType: .get, parameters: parameter) { (response) in
            guard let responseDic = response as? [String : AnyObject] else { return }
            guard let responseArr = responseDic["data"] as? [[String : AnyObject]] else { return }
            self.twoGroup.tag_name = "颜值"
            self.twoGroup.icon_url = "home_header_phone"
            for dict in responseArr{
                let faceGroup = AnchorModel(dict: dict)
                self.twoGroup.anchors.append(faceGroup)
            }
            netGroup.leave()
        }
        netGroup.enter()
        // 游戏数据
        NetworkTools.requestData(urlString:"http://capi.douyucdn.cn/api/v1/getHotCate", methodType: .get, parameters:parameter) { (response) in
            guard let responseDic = response as? [String : AnyObject] else {return}     //走的6
            guard let responseArr = responseDic["data"] as? [[String : AnyObject]] else {return}
            for dict in responseArr{
                let group = AnchorGroup(dict: dict)
                self.threeGroup.append(group)
            }
            netGroup.leave()
        }

        netGroup.notify(queue: DispatchQueue.main) {
            self.threeGroup.insert(self.twoGroup, at: 0)
            self.threeGroup.insert(self.oneGroup, at: 0)
            finishCallback()
        }
    }
}
