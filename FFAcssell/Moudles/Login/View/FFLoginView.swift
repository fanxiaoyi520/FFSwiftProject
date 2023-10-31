//
//  FFLoginView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/30.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

protocol FFLoginViewDelegate : AnyObject{
    func loginViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func loginViewSelectIndex(index: Int)
}

class FFLoginView : UIView {

    weak var delegate : FFLoginViewDelegate?
    
    lazy var homeCollectionView : FFHomeCollectionView = {
        let collectionView = FFHomeCollectionView(dataItems: loginTypeArr(),frame: CGRect(x: 25, y: 0, width: getScreenWidth()-25*2, height: 51))
        collectionView.delegate = self
        return collectionView
    }()
    
    let scrolloView: UIScrollView = {
        let scrolloView = UIScrollView()
        scrolloView.frame = CGRect(x: 0, y: 53+12, width: getScreenWidth(), height: 53*2+12)
        scrolloView.showsVerticalScrollIndicator = false
        scrolloView.showsHorizontalScrollIndicator = false
        scrolloView.contentInsetAdjustmentBehavior = .never
        scrolloView.alwaysBounceHorizontal = true
        return scrolloView
    }()
    
    let accountAndPwdLoginView: FFAccountAndPwdLoginView = {
        let view = FFAccountAndPwdLoginView()
        return view
    }()
    
    let codeLoginView: FFCodeLoginView = {
        let view = FFCodeLoginView()
        return view
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.addSubview(homeCollectionView)
        self.addSubview(scrolloView)
        scrolloView.delegate = self

        for (index,_) in loginTypeArr().enumerated() {
            scrolloView.contentSize = CGSize(width: getScreenWidth()*2, height: 53*2+12)
            if (index == 0) {
                scrolloView.addSubview(accountAndPwdLoginView)
                accountAndPwdLoginView.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: 53*2+12)
            } else {
                scrolloView.addSubview(codeLoginView)
                codeLoginView.frame = CGRect(x: getScreenWidth(), y: 0, width: getScreenWidth(), height: 53*2+12)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FFLoginView : FFHomeCollectionViewDelegate,UIScrollViewDelegate {

    func taskDetailsCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screenWidth = UIScreen.main.bounds.width
        let scrollDistance = CGFloat(indexPath.item) * screenWidth
        scrolloView.setContentOffset(CGPoint(x: scrollDistance, y: 0), animated: true)
        
        if self.delegate != nil {
            self.delegate?.loginViewCollectionCollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == scrollView else { return }
        let screenWidth = UIScreen.main.bounds.width
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX.truncatingRemainder(dividingBy: screenWidth) == 0 {
            // 滚动结束后，根据滚动距离更新UICollectionView的当前选中项
            let selectedIndex = Int(contentOffsetX / screenWidth)
            homeCollectionView.updateTabbar(index: selectedIndex)
            
            if self.delegate != nil {
                self.delegate?.loginViewSelectIndex(index: selectedIndex)
            }
        }
    }
}
