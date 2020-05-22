//
//  StockHeaderView.swift
//  InternalSystem
//
//  Created by gail on 2018/3/13.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class StockHeaderView: UIView {
    
    lazy var cycleScrollView : SDCycleScrollView = {
        let cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: HeadViewHeight), delegate: self, placeholderImage: nil)
        cycleScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        cycleScrollView?.currentPageDotColor = UIColor.white
        return cycleScrollView!
    }()
    lazy var containerView = { () -> UIScrollView in
        let containerView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: HeadViewHeight))
        addSubview(containerView)
        return containerView
    }()
    var stockProductModel:StockProductModel? {
        didSet{
            let str = stockProductModel?.ProdImages
            let result = str?.components(separatedBy: ",")
            cycleScrollView.imageURLStringsGroup = result
            containerView.contentSize = CGSize(width: width*CGFloat(cycleScrollView.imageURLStringsGroup.count), height: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.groupTableViewBackground
        containerView.addSubview(cycleScrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension StockHeaderView:SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {

    }
}
