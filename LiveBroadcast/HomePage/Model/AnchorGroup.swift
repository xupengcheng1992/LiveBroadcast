//
//  AnchorGroup.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/6/11.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit
//MARK:- room_list第二层字典
class AnchorGroup: NSObject {
    @objc var tag_name : String = ""
    @objc var icon_url : String = ""

    //定义主播的模型对象数组
    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //房间列表
    @objc var room_list : [[String : AnyObject]]?{
        didSet{
            guard let room_list = room_list else {return}
            for dic in room_list{
                anchors.append(AnchorModel(dict: dic))
            }
        }
    }
    //标题名称
    override init() {}
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
