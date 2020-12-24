//
//  TabBarItem_Extension.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/10.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //类方法
    class func creatItem(defaltImg:String,selectImg:String,size:CGSize)->UIBarButtonItem{
        let button=UIButton()
        button.setImage(UIImage(named: defaltImg), for: .normal)
        button.setImage(UIImage(named: selectImg), for: .highlighted)
        button.frame=CGRect(origin:CGPoint.zero, size: size)
        return UIBarButtonItem(customView: button)
    }
    
    convenience init(defaltImg : String, selectImg :String="", size : CGSize=CGSize.zero){
        let button = UIButton()
        
        button.setImage(UIImage(named: defaltImg), for: .normal)
        
        if selectImg != "" {
            button.setImage(UIImage(named: selectImg), for: .highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            button.sizeToFit()
        } else {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:button)
    }
}
