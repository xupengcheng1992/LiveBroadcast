//
//  ReusableCell.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/23.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit
import SnapKit

class ReusableCell: UICollectionReusableView {
    let leftImage = UIImageView()
    let leftLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var group : AnchorGroup?{
        didSet{
            leftLabel.text = group?.tag_name
        }
    }
}

extension ReusableCell{
    func setUp(){
        //        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 10))
        //        topView.backgroundColor = UIColor(r: 234, g: 234, b: 234)
        //        self.addSubview(topView)
        let topView = CALayer()
        topView.backgroundColor = UIColor(r: 234, g: 234, b: 234).cgColor
        topView.frame = CGRect(x: 0, y: 0, width: KScreenW, height: 10)
        self.layer.addSublayer(topView)
        
        
        leftImage.image = UIImage(named: "home_header_hot")
        leftImage.sizeToFit()
        self.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(10)
        }
        
        self.addSubview(leftLabel)
//        leftLabel.text = "视频"
        leftLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(leftImage)
            make.left.equalTo(leftImage.snp.right).offset(5)
        })
        
        let rightBtn = UIButton()
        self.addSubview(rightBtn)
        rightBtn.setTitle("更多 >", for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(60)
        }
    }
}
