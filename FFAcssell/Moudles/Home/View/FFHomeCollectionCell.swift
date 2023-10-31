//
//  FFHomeCollectionCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let itemHeight = 51.0

class FFHomeCollectionCell: UICollectionViewCell {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithPFRegular(15)
        label.textColor = Theme.titleColor()
        label.textAlignment = .center
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = Theme.lineViewColor1()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(lineView)
        
        titleLab.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override var isSelected: Bool {
        didSet {
            lineView.isHidden = !isSelected
        }
    }
}

protocol FFHomeCollectionViewDelegate: AnyObject {
    func taskDetailsCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}


class FFHomeCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    weak var delegate: FFHomeCollectionViewDelegate?

    convenience init(dataItems:Array<String>,frame:CGRect) {
        self.init(frame:frame)
        self.dataItems = dataItems
        addSubview()
        addConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var dataItems: Array<String>?
    
    func addSubview() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Int(self.bounds.width), height: Int(itemHeight)), collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(FFHomeCollectionCell.self, forCellWithReuseIdentifier: "FFHomeCollectionCell")
        addSubview(collectionView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
    }
    
    func setGradientLayer(startColor: UIColor, endColor: UIColor, view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        view.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 0.5, 1.0]
    }
    
    func addConstraints() {
        // Add your constraints here
    }
    
//    func setRzzmodel(rzzmodel: MMSelectItemFloor) {
//        self.rzzmodel = rzzmodel
//        self.dataItems = rzzmodel.rooms
//        self.collectionView.reloadData()
//    }
//
//    func setModel(model: MMSelectItemRoomNumber) {
//        self.model = model
//        for (index, obj) in self.rzzmodel.rooms.enumerated() {
//            if model.roomId == obj.roomId {
//                let indexPath = IndexPath(row: index, section: 0)
//                self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .none)
//            }
//        }
//    }
    public func updateTabbar(index:Int) -> Void {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FFHomeCollectionCell", for: indexPath) as! FFHomeCollectionCell
        guard let model = self.dataItems,!model.isEmpty else { return cell}
        cell.titleLab.text = self.dataItems?[indexPath.row]
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(dataItems?.count ?? 3)
        return CGSize(width: getScreenWidth() / count, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.taskDetailsCollectionCollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
