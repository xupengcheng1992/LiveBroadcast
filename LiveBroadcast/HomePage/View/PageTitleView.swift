//
//  PageTitleView.swift
//  斗鱼直播
//
//  Created by 许鹏程 on 2019/5/13.
//  Copyright © 2019 许鹏程. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let KLineH : CGFloat = 2
private let KNormalColour : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColour : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    private var currentIndex : Int = 0
    private var field : [String]
    weak var delegate : PageTitleViewDelegate?
    //MARK: 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.orange
        return bottomLine
    }()
    
    //MARK: 函数初始化构建
    init(frame: CGRect,field :[String]) {
        self.field=field
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    private func setUp(){
        addSubview(scrollView)
        self.backgroundColor = UIColor.white
        scrollView.frame = bounds
        setTitleStr()
        setBottomLine()
    }
    
    private func setTitleStr(){
        let labelW : CGFloat = frame.width / CGFloat(field.count)
        let labelH : CGFloat = frame.height - KLineH
        let labelY : CGFloat = 0
        for (index,titleStr) in field.enumerated() {
            let label = UILabel()
            label.text = titleStr
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            //设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            if index == 0 {
                label.textColor = UIColor.orange
            }else{
                label.textColor = UIColor.gray
            }
            scrollView.addSubview(label)
            titleLabels.append(label)
            //添加手势
            label.isUserInteractionEnabled = true
            let tapes = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tapes:)))
            label.addGestureRecognizer(tapes)
        }
    }
    
    //添加滑动线
    private func setBottomLine(){
        guard let firstLabel = titleLabels.first else { return }
        scrollView.addSubview(bottomLine)
        bottomLine.frame = CGRect(x: 0, y: frame.height - KLineH , width: firstLabel.frame.width, height: KLineH)
    }
}

extension PageTitleView{
    @objc private func labelClick(tapes : UITapGestureRecognizer){
        guard let currentLabel = tapes.view as? UILabel else { return }
        //如果重复点击同一个title
        if currentLabel.tag == currentIndex { return }
        //获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor(r: KSelectColour.0, g: KSelectColour.1, b: KSelectColour.2)
        oldLabel.textColor = UIColor(r: KNormalColour.0, g: KNormalColour.1, b: KNormalColour.2)
        //更新currentIndex
        currentIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentLabel.tag) * bottomLine.frame.width
        UIView.animate(withDuration: 0.2, animations:  {
            self.bottomLine.frame.origin.x = scrollLineX
        })
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK:- 对外暴漏方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat, sourceIndex :Int, targetIndex : Int){
        //滑块的设置
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        bottomLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色渐变处理
        let colourDelta = (KSelectColour.0 - KNormalColour.0, KSelectColour.1 - KNormalColour.1, KSelectColour.2 - KNormalColour.2)
        sourceLabel.textColor = UIColor(r: KSelectColour.0 - colourDelta.0 * progress, g: KSelectColour.1 - colourDelta.1 * progress, b: KSelectColour.2 - colourDelta.2 * progress)
        targetLabel.textColor = UIColor(r: KNormalColour.0 + colourDelta.0 * progress, g: KNormalColour.1 + colourDelta.1 * progress, b: KNormalColour.2 + colourDelta.2 * progress)
        currentIndex = targetIndex
    }
}
