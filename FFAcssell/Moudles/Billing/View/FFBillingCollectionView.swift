//
//  FFBillingCollectionView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/12.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol FFBillingCollectionViewCellDelegate : AnyObject {
    func add(sender:UIButton)
}

class FFBillingCollectionViewCell: UICollectionViewCell {
    
    weak var delegate : FFBillingCollectionViewCellDelegate?
    
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
    
    let addBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "app_add"), for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    let numLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithPFRegular(10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = Theme.btnBackgroundColor()
        label.text = "0"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(lineView)
        contentView.addSubview(addBtn)
        contentView.addSubview(numLab)
        
        titleLab.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(1)
        }
        
        addBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.width.height.equalTo(30)
            make.right.equalTo(-20)
        }
        
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.width.height.equalTo(20)
            make.right.equalTo(-10)
        }
        
        addBtn.addTarget(self, action: #selector(addBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func addBtn(_ sender:UIButton) -> Void {
        if let delegate = self.delegate  {
            delegate.add(sender: sender)
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

protocol FFBillingCollectionViewDelegate: AnyObject {
    func taskDetailsCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func addProject(sender:UIButton)
}


class FFBillingCollectionView: UIView {
    
    var collectionView: UICollectionView!
    weak var delegate: FFBillingCollectionViewDelegate?

    var allNum: Int64 = 0
    
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
        collectionView.register(FFBillingCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "FFBillingCollectionViewCell")
        addSubview(collectionView)
        
        let indexPath = IndexPath(item: 0, section: 0)
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
    
    //MARK: method
    public func updateTabbar(index:Int) -> Void {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
    
    public func updateNum(num:Int64) -> Void {
        self.allNum = num
        self.collectionView.reloadData()
    }
}

extension FFBillingCollectionView : FFBillingCollectionViewCellDelegate {
    func add(sender: UIButton) {
        debugPrint("====新增项目:\(sender)")
        if self.delegate != nil {
            self.delegate?.addProject(sender: sender)
        }
    }
}

extension FFBillingCollectionView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FFBillingCollectionViewCell", for: indexPath) as! FFBillingCollectionViewCell
        guard let model = self.dataItems,!model.isEmpty else { return cell}
        cell.titleLab.text = self.dataItems?[indexPath.row]
        cell.numLab.text = "\(self.allNum)"
        cell.numLab.isHidden = indexPath.row == (dataItems?.count ?? 2) - 1 ? false : true
        cell.addBtn.isHidden = indexPath.row == (dataItems?.count ?? 1) - 2 ? false : true
        cell.delegate = self
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
