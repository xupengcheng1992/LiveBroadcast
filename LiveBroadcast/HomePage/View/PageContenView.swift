//
//  PageContenView.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/14.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

protocol pageContentViewDelegate : class {
    func pageContenView(contenView : PageContenView, progress : CGFloat, sourceIndex : Int, targeIndex :Int)
}


//MARK:-申明属性，Class入口
class PageContenView: UIView {
    // 定义属性
    private var childVCs : [UIViewController]
    private weak var parentVC : UIViewController?
    private var startOffer : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : pageContentViewDelegate?
    private let contenCellID = "contenCellID"
    
    // 懒加载属性
    private lazy var collectonView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellID)
        return collectionView
    }()
    
    // 构造函数
    init(frame: CGRect , childVCs : [UIViewController] ,parentVC : UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- setUp
extension PageContenView{
    private func setUp(){
        for child in childVCs{
            parentVC?.addChild(child)
        }
        addSubview(collectonView)
        collectonView.frame = bounds
    }
}

//MARK:- 遵守collectionView的dataSource协议
extension PageContenView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contenCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

//MARK:- 遵守collectionView的Delegate协议
extension PageContenView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffer = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        // 偏移量的比例值
        var progress : CGFloat = 0
        // 当前偏移量标记
        var sourceIndex : Int = 0
        // 目标偏移量标记
        var targgetIndex :Int = 0
        // 结束滑动的偏移量数值
        let contenOffset = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        if contenOffset > startOffer{
            //左滑
            let number = floor(contenOffset / scrollViewWidth)
            progress = contenOffset /  scrollViewWidth - number
            sourceIndex = Int(contenOffset /  scrollViewWidth)
            targgetIndex = sourceIndex + 1
            if targgetIndex >= childVCs.count{
                targgetIndex = childVCs.count - 1
            }
            //如果完全滑过一页
            if contenOffset - startOffer == scrollViewWidth{
                progress = 1
                targgetIndex = sourceIndex
            }
        }else{
            //右滑
            progress = 1 - (contenOffset /  scrollViewWidth - floor(contenOffset / scrollViewWidth))
            targgetIndex = Int(contenOffset / scrollViewWidth)
            sourceIndex = targgetIndex + 1
            if sourceIndex >= childVCs.count{
                sourceIndex = childVCs.count - 1
            }
        }
//        print("progress:%f,oldIndex:%zd,newIndex:%zd",progress,targgetIndex,sourceIndex)
        delegate?.pageContenView(contenView: self, progress: progress, sourceIndex: sourceIndex, targeIndex: targgetIndex)
    }
}

//MARK:- 对外暴漏方法设置pageContenView的偏移量
extension PageContenView{
    func setCurrentIndex(currentIndex : Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex)  * collectonView.frame.width
        collectonView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

