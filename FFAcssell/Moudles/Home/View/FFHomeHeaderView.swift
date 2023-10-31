//
//  FFHomeHeaderView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

protocol FFHomeHeaderViewDelegate: AnyObject {
    func homeHeaderViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class FFHomeHeaderView : UIView {

    var homeCollectionView : FFHomeCollectionView {
        let _homeCollectionView = FFHomeCollectionView(dataItems: dataItems ?? statusArr(),frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 51))
        _homeCollectionView.delegate = self
        return _homeCollectionView
    }
    
    weak var delegate: FFHomeHeaderViewDelegate?
    
    var dataItems: Array<String>? = statusArr()
    
    convenience init(dataItems:Array<String>? = statusArr(),frame:CGRect) {
        self.init(frame: frame)
        self.dataItems = dataItems
        self.backgroundColor = UIColor.white
        self.addSubview(homeCollectionView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FFHomeHeaderView : FFHomeCollectionViewDelegate {
    
    func taskDetailsCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.homeHeaderViewCollectionCollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
