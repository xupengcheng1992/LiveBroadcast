//
//  RecommendGameCell.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2020/10/29.
//  Copyright © 2020 许鹏程. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendGameCell: UICollectionViewCell {
    var titleLabel : UILabel!
    var titleImg : UIImageView!
    
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            guard let iconUrl = URL(string: group?.icon_url ?? "")else{ return }
            titleImg.kf.setImage(with: iconUrl,placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendGameCell{
    func setUp(){
        titleImg = UIImageView(frame: CGRect(x: 0, y: 15, width: 45, height: 45))
        self.addSubview(titleImg)
        titleImg.center.x = self.bounds.width / 2
        titleImg.layer.cornerRadius = 22.5
        titleImg.layer.masksToBounds = true

        titleLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 100, height: 30))
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "英雄联盟"
        self.addSubview(titleLabel)
        titleLabel.center.x = self.bounds.width / 2
        titleLabel.textAlignment = .center
    }
}
