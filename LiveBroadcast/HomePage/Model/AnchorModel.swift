//
//  AnchorModel.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/6/11.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间图片的URl
    @objc var vertical_src : String = ""
    //房间名称
    @objc var room_name : String = ""
    //主播名称
    @objc var nickname : String = ""
    //观看人数
    @objc var online : Int = 0
    //房间号
    @objc var room_id : Int = 0
    //判断是手机直播还是电脑直播
    // 0 判断电脑直播 1 判断手机直播
    @objc var isVertical : Int = 0
    //主播所在城市
    @objc var anchor_city : String = ""
    
    init(dict : [String : AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {}
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
