//
//  HomePageVC.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/10.
//  Copyright © 2019 许鹏程. All rights reserved.
//


//MARK:- 全局控制器
import UIKit
import Alamofire
//MARK:- 声明常量属性
private let KTitleViewH : CGFloat = 40
private let sizes = CGSize(width: 40, height: 40)

class HomePageVC: UIViewController {
    //滚动条
    let titleStr = ["推荐","游戏","娱乐","趣玩"]
    private lazy var dataViewModel : DataViewModel = DataViewModel()
    //懒加载
    private lazy var pageTitleView :PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH, width: KScreenW, height: KTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, field: titleStr)
        titleView.delegate = self
        return titleView
    }()
    
    //内容界面展示
    private lazy var pageContenView : PageContenView = {[weak self] in
        let contenFrameH = KScreenH - KTitleViewH - KNavigationBarH - KStatusBarH - KTabBarH
        let contenFrame = CGRect(x: 0, y: KTitleViewH + KStatusBarH + KNavigationBarH, width: KScreenW, height: contenFrameH)
        var childVCs = [UIViewController]()
        childVCs.append(RecommendVC())
        childVCs.append(GameViewVC())
        
        for _ in 0..<2{
            let VC = UIViewController()
            VC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(VC)
        }
        let pageContenView = PageContenView(frame: contenFrame, childVCs: childVCs, parentVC: self)
        pageContenView.delegate = self
        return pageContenView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}



//MARK:- setUp
extension HomePageVC{
        private func setUp(){
        setNav()
        view.addSubview(pageTitleView)
        view.addSubview(pageContenView)
    }
        private func setNav(){
        
        let logoBtn = UIButton()
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        logoBtn.setImage(UIImage(named: "logo"),for: .normal)
        
        logoBtn.sizeToFit()
         
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        let rightItem = UIBarButtonItem.init(defaltImg: "right", selectImg: "rights", size: sizes)

        let searchItem = UIBarButtonItem.init(defaltImg: "search", selectImg: "searchs", size: sizes)

        let qrcodeItem = UIBarButtonItem.creatItem(defaltImg: "qrcode", selectImg: "qrcodes", size: sizes)
        navigationItem.rightBarButtonItems = [rightItem,searchItem,qrcodeItem]
    }
}

//MARK:- 遵守pageTitle的Delegate
extension HomePageVC : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- 遵守pageContenView的Delegate
extension HomePageVC : pageContentViewDelegate{
    func pageContenView(contenView: PageContenView, progress: CGFloat, sourceIndex: Int, targeIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targeIndex)
    }
}
