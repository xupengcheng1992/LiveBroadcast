//
//  NSDate-Extension.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/5/29.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import Foundation
extension NSDate {
    static func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
