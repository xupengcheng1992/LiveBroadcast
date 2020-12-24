//
//  TabBarVC.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/10.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
    }
}

extension TabBarVC{
    private func SetUp(){
        let homePageVC=HomePageVC()
        let gameVC=GameVC()
        let showVC=ShowVC()
        let setVC=SetVC()
        
        let vcArr=[homePageVC,gameVC,showVC,setVC]
        let titleArr=["首页","游戏直播","秀直播","我的"]
        let defaultImg=["home","column","live","set"]
        let selectImg=["homes","columns","lives","sets"]
        
        for (index,_) in vcArr.enumerated(){
            setChildFunction(vc: UINavigationController.init(rootViewController: vcArr[index]), title: titleArr[index], defaultImg: defaultImg[index], selectImg: selectImg[index])
        }
    }
    
     private  func setChildFunction(vc:UIViewController,title:String,defaultImg:String,selectImg:String){
        //标题文字
        vc.tabBarItem.title=title
        //图片渲染
        vc.tabBarItem.image=UIImage(named: defaultImg)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage=UIImage(named: selectImg)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //文字渲染
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 236.0/255.0, green: 126.0/255.0, blue: 49.0/255.0, alpha: 1.0)]
        vc.tabBarItem.setTitleTextAttributes(attributes, for:.selected)
        self.addChild(vc);
    }
}
