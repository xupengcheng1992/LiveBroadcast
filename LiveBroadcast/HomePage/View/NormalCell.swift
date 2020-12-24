//
//  NormalCell.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/5/23.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCell: BaseCell {
    //房间名
    @objc let leftLabel : UILabel = UILabel()

    @objc override var model : AnchorModel?{
        didSet{
            super.model = model
            //房间名
            leftLabel.text = model?.room_name
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NormalCell{
    func setUp(){
        let bottomImg = UIImageView()
        self.addSubview(bottomImg)
        bottomImg.image = UIImage(named: "home_live_cate_normal")
        bottomImg.snp.makeConstraints { (make) in
            make.bottom.equalTo(-5)
            make.left.equalTo(0)
        }
        bottomImg.sizeToFit()
        
        self.addSubview(leftLabel)
        leftLabel.font = UIFont.systemFont(ofSize: 11)
        leftLabel.text = "iOS开发大牛许鹏程"
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bottomImg.snp.top)
            make.left.equalTo(bottomImg.snp.right).offset(2)
            make.right.equalTo(-1)
        }
//        leftLabel.backgroundColor = .red
        leftLabel.numberOfLines = 0
        leftLabel.textColor = UIColor.gray
        
        self.addSubview(imageView)
        imageView.image = UIImage(named: "Img_default")
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-22)
        }
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        self.addSubview(anchorLabel)
        anchorLabel.text = "iOS大牛许鹏程"
        anchorLabel.textColor = UIColor.white
        anchorLabel.font = UIFont.systemFont(ofSize: 11)
        anchorLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(leftLabel.snp.top).offset(-5)
            make.left.equalTo(2)
        }
        
        self.addSubview(onlineBtn)
        onlineBtn.setImage(UIImage(named: "Image_online"), for: .normal)
        onlineBtn.setTitle("666", for: .normal)
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        onlineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-2)
            make.centerY.equalTo(anchorLabel)
        }
    }
}
