//
//  RecommendVC.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/23.
//  Copyright © 2019 许鹏程. All rights reserved.
//

//MARK:- 主页内容
import UIKit
//MARK:- 声明常量
let KItemMargin : CGFloat = 10
let KItemW : CGFloat = (KScreenW - KItemMargin * 3) / 2
let KNormalItemH : CGFloat = KItemW * 3 / 4
let KVideoItemH : CGFloat = KItemW * 4 / 3 
let KHeadViewCellH : CGFloat = 50
let KNormalCellID = "KNormalCellID"
let KHeadViewCellID = "KHeadViewCellID"
let KVideoCellID = "KVideoCellID"
let KCarouselViewHeight = KScreenW * 3/8
let KRecommendHeight : CGFloat = 90

class RecommendVC: UIViewController {
    lazy var dataArray : [AnchorModel] = [AnchorModel]()
    lazy var tempArray : [AnchorModel] = [AnchorModel]()
    lazy var frontArr : [AnchorModel] = [AnchorModel]()
    
    private lazy var dataViewModel : DataViewModel = DataViewModel()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KNormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeadViewCellH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //设置collection的内边距
        collectionView.contentInset = UIEdgeInsets(top: KCarouselViewHeight + KRecommendHeight, left: 0, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        //游戏Cell
        collectionView.register(NormalCell.self, forCellWithReuseIdentifier: KNormalCellID)
        //头视图Cell
        collectionView.register(ReusableCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeadViewCellID)
        //视频Cell
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: KVideoCellID)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    //轮播图
    private lazy var carouselView : CarouselView = { [unowned self] in
        let carouselView = CarouselView(frame: CGRect(x: 0, y: -(KCarouselViewHeight + KRecommendHeight), width: KScreenW, height: KCarouselViewHeight))
        return carouselView
    }()
    
    private lazy var recommendGamesView : RecommendGames = { [unowned self] in
        let recommendGamesView = RecommendGames(frame: CGRect(x: 0, y: -(KCarouselViewHeight + KRecommendHeight) + KCarouselViewHeight, width: KScreenW, height: KRecommendHeight))
        recommendGamesView.backgroundColor = .red
        return recommendGamesView
    }()
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }
}

//MARK:- 请求数据
extension RecommendVC {
    func loadData(){
        dataViewModel.resquestData {
            self.collectionView.reloadData()
            self.tempArray  = self.dataViewModel.oneGroup.anchors.reversed()
            for i in 0..<6{
                self.frontArr.append(self.tempArray[i])
            }
            self.carouselView.cycleModels = self.frontArr
            self.recommendGamesView.grous = self.dataViewModel.threeGroup
        }
    }
}

//MARK:- 初始化UI
extension RecommendVC {
    func setUp(){
        view.addSubview(collectionView)
        collectionView.addSubview(carouselView)
        collectionView.addSubview(recommendGamesView)
        view.backgroundColor = UIColor.white
    }
}

//MARK:- 遵守CollectionView的DataSource
extension RecommendVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    // 组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataViewModel.threeGroup.count
    }
    
    //每组有多少个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = dataViewModel.threeGroup[section]
        //        print(group.anchors.count)
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = dataViewModel.threeGroup[indexPath.section]
        let model = section.anchors[indexPath.item]
        var cell : BaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KVideoCellID, for: indexPath)as! VideoCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)as! NormalCell
        }
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadViewCellID, for: indexPath) as! ReusableCell
        headCell.group = dataViewModel.threeGroup[indexPath.section]
        return headCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: KItemW, height: KVideoItemH)
        }else{
            return CGSize(width: KItemW, height: KNormalItemH)
        }
    }
}
