//
//  CarouselView.swift
//  LiveBroadcast
//
//  Created by 许鹏程 on 2020/5/28.
//  Copyright © 2020 许鹏程. All rights reserved.
//

import UIKit

let CellID = "CellID"

class CarouselView: UIView {
    var cycleTimer : Timer?
    
    var cycleModels : [AnchorModel]?{
        didSet{
            self.collectionView.reloadData()
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    var pageView : UIPageControl!
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)! as CGSize
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: (self?.bounds.width)!, height: KScreenW * 3/8), collectionViewLayout: layout)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CellID)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
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

extension CarouselView{
    func setUp(){
        self.backgroundColor = .orange
        self.addSubview(collectionView)
        
        pageView = UIPageControl()
        self.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-4)
            make.right.equalTo(60)
            make.width.equalTo(260)
            make.height.equalTo(20)
        }
        pageView.numberOfPages = 6
        pageView.currentPageIndicatorTintColor = .orange
        pageView.pageIndicatorTintColor = .white
    }
}

extension CarouselView : UICollectionViewDataSource,UICollectionViewDelegate{
    //每组多少个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! CarouselCell
        cell.model = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + self.bounds.width * 0.5
        self.pageView.currentPage = Int(offsetX / self.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension CarouselView{
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .default)
    }
    
    func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offSetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
    
}
