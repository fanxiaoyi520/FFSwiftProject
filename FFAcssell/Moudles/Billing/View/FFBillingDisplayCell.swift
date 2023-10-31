//
//  FFOrderDetailsCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol FFBillingDisplayCellDelegate : AnyObject {
    func billingDisplayCelladdBtnAction(sender:UIButton,tableView:UITableView)
}

class FFBillingDisplayCell: UITableViewCell {
    
    weak var delegate : FFBillingDisplayCellDelegate?
    
    // 标题标签
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("商品:")
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("单价:")
        return label
    }()

    
    // 子标题标签
    let subTitleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let subTitleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.red
        return label
    }()

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    let addBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(13)
        button.setTitle(kLanguage("加入购物车"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        return button
    }()
    
    var item0: ProductInfo? {
        didSet {
            guard item0 != nil else { return }
            subTitleLab1.text = item0?.productName
            subTitleLab2.text = "¥\(item0?.price1 ?? 0.0)"
        }
    }
    
    var item1: ItemInfo? {
        didSet {
            guard item1 != nil else { return }
            subTitleLab1.text = item1?.itemName
            subTitleLab2.text = "¥\(item1?.price ?? 0.0)"
        }
    }
    
    weak var tableView: UITableView? 

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab1)
        contentView.addSubview(titleLab2)

        // 添加子标题标签
        contentView.addSubview(subTitleLab1)
        contentView.addSubview(subTitleLab2)
        contentView.addSubview(addBtn)

        contentView.addSubview(lineView)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab1.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        // 设置子标题标签约束（靠右边距 25，并垂直居中）
        subTitleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab1.snp.right).offset(10)
            make.centerY.equalTo(titleLab1)
            make.height.greaterThanOrEqualTo(20)
        }
        
        subTitleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab2.snp.right).offset(10)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.centerY.equalTo(titleLab2)
            make.height.equalTo(34)
            make.width.greaterThanOrEqualTo(100)
        }
        
        lineView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 79, left: 25, bottom: 0, right: 0))
        }
        
        addBtn.addTarget(self, action: #selector(addBtnAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addBtnAction(_ sender:UIButton) -> Void {
        if self.delegate != nil {
            self.delegate?.billingDisplayCelladdBtnAction(sender: sender,tableView: tableView ?? UITableView())
        }
    }
}
