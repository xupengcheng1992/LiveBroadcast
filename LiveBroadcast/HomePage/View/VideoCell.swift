//
//  VideoCell.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2019/5/24.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    var addressLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc override var model : AnchorModel?{
        didSet{
            super.model = model
            //位置
            self.addressLabel.text = model?.anchor_city
        }
    }
}

extension VideoCell{
    func setUp(){
        imageView.image = UIImage(named: "live_cell_default_phone")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-50)
        }
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        self.addSubview(anchorLabel)
        anchorLabel.text = "许鹏程世界第一武器"
        anchorLabel.textColor = UIColor.black
        anchorLabel.font = UIFont.systemFont(ofSize: 14)
        anchorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.equalTo(2)
        }
        
        onlineBtn.backgroundColor = UIColor.gray
        onlineBtn.setTitleColor(UIColor.white, for: .normal)
        onlineBtn.setTitle("666在线", for: .normal)
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        onlineBtn.contentHorizontalAlignment = .center
        self.addSubview(onlineBtn)
        onlineBtn.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-8)
            make.width.equalTo(60)
        }
        onlineBtn.layer.cornerRadius = 5
        onlineBtn.layer.masksToBounds = true
        
        let coordinateImg = UIImageView()
        coordinateImg.image = UIImage(named: "ico_location")
        self.addSubview(coordinateImg)
        coordinateImg.snp.makeConstraints { (make) in
            make.top.equalTo(anchorLabel.snp.bottom).offset(5)
            make.left.equalTo(anchorLabel.snp.left)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        addressLabel = UILabel()
        addressLabel.text = "北京市"
        addressLabel.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(coordinateImg.snp.centerY)
            make.left.equalTo(coordinateImg.snp.right).offset(3)
        }
    }
}
