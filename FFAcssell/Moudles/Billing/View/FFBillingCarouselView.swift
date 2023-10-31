//
//  FFBillingCarouselView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/12.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

protocol FFBillingCarouselViewDelegate: AnyObject {
    func billingCarouselViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func addProject(sender:UIButton)
}

class FFBillingCarouselView : UIView {
    
    lazy var billingCollectionView : FFBillingCollectionView = {
        let view = FFBillingCollectionView(dataItems: dataItems,frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 51))
        view.delegate = self
        return view
    }()
    
    weak var delegate: FFBillingCarouselViewDelegate?
    
    var dataItems: Array<String> = []
    
    convenience init(dataItems:Array<String>,frame:CGRect) {
        self.init(frame: frame)
        self.dataItems = dataItems
        self.backgroundColor = UIColor.white
        self.addSubview(billingCollectionView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: method
    public func updateTabbar(index:Int) -> Void {
        self.billingCollectionView.updateTabbar(index: index)
    }
    
    public func updateNum(num:Int64) -> Void {
        self.billingCollectionView.updateNum(num: num)
    }
}

extension FFBillingCarouselView : FFBillingCollectionViewDelegate {
    func addProject(sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.addProject(sender: sender)
        }
    }
    
    func taskDetailsCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.billingCarouselViewCollectionCollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
