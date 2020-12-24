//
//  RecommendGames.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2020/10/28.
//  Copyright © 2020 许鹏程. All rights reserved.
//

import UIKit

let cellId = "cellId"
let KEdgeInsetMargin : CGFloat = 10

class RecommendGames: UIView {
    
    var grous : [AnchorGroup]?{
        didSet{
            grous?.removeFirst()
            grous?.removeFirst()
//            let moreGroup = AnchorGroup()
//            moreGroup.tag_name = "更多"
//            grous?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: (self?.bounds.width)!, height: 90), collectionViewLayout: layout)
        collectionView.register(RecommendGameCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: KEdgeInsetMargin, bottom: 0, right: KEdgeInsetMargin)
//        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RecommendGames{
    func setUp(){
        self.addSubview(collectionView)
    }
}


extension RecommendGames:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grous?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommendGameCell
        cell.group = grous![indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
    
    
}
