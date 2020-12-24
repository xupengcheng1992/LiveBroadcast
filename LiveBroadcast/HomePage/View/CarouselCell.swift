//
//  CarouselCell.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2020/10/9.
//  Copyright © 2020 许鹏程. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    var imageView  : UIImageView = UIImageView()
    var titleLabel : UILabel!
    
    var model : AnchorModel?{
        didSet{
            guard let model = model else { return }
            guard let iconUrl = URL(string: model.vertical_src)else{ return }
            imageView.kf.setImage(with: iconUrl)
            titleLabel.text = model.room_name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame  = self.contentView.frame
    }
    
}

extension CarouselCell{
    func setUp(){
        imageView.image = UIImage(named: "Placeholder")
        self.contentView.addSubview(imageView)
        
        let occludeView = UIView()
        self.addSubview(occludeView)
        occludeView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(26)
        }
        occludeView.backgroundColor = .gray
        occludeView.alpha = 0.4
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-3)
            make.height.equalTo(20)
            make.right.equalTo(0)
        }
    }
}
