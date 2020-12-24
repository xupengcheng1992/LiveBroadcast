//
//  Colour_Extension.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/14.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}

