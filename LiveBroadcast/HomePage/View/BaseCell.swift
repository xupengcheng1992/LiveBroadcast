//
//  BaseCell.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/9/16.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    @objc var imageView  : UIImageView = UIImageView()
    //主播昵称
    @objc var anchorLabel : UILabel = UILabel()
    //在线人数
    @objc var onlineBtn : UIButton = UIButton()
    
    @objc var model : AnchorModel?{
        didSet{
            //检验模型是否是有值
            guard let model = model else{ return }
            var onlineStr : String = ""
            if(model.online >= 1000){
                onlineStr = "\(Int(model.online / 10000))万在线"
            }else{
                onlineStr = "\(model.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //主播名称
            anchorLabel.text = model.nickname
            //占位图
            guard let iconUrl = URL(string: model.vertical_src)else{ return }
            imageView.kf.setImage(with: iconUrl)
        }
    }
}
