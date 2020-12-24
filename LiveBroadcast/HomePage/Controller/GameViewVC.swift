//
//  GameViewVC.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2020/11/4.
//  Copyright © 2020 许鹏程. All rights reserved.
//

import UIKit

private let KEdgeMargin : CGFloat = 10
private let KitemW : CGFloat = (KScreenW - 2 * KEdgeMargin)/3
private let KitemH : CGFloat = KItemW * 6 / 5


class GameViewVC: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KitemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self!.view.bounds,collectionViewLayout: layout)
        return collectionView
    }() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension GameViewVC{
    
}
