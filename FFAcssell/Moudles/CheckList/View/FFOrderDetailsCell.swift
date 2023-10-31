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

class FFOrderDetailsCell: UITableViewCell {
    
    // 标题标签
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("编号:")
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("单价:")
        return label
    }()

    let titleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("数量:")
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
        return label
    }()
    
    let subTitleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    var item: ProductInfo? {
        didSet {
            guard let item = item else { return }
            if (item.productId > 0) {
                titleLab1.text = "商品"
                titleLab1.textColor = UIColor.red
                subTitleLab1.text = item.productName
            } else {
                if (item.stockId > 0) {
                    titleLab1.text = "项目"
                    titleLab1.textColor = Theme.btnBackgroundColor()
                    subTitleLab1.text = item.productName
                } else {
                    titleLab1.text = "临时"
                    titleLab1.textColor = UIColor.yellow
                    subTitleLab1.text = item.productName
                }
            }
            subTitleLab2.text = "\(item.outPrice)"
            subTitleLab3.text = "\(item.qty )"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab1)
        contentView.addSubview(titleLab2)
        contentView.addSubview(titleLab3)

        // 添加子标题标签
        contentView.addSubview(subTitleLab1)
        contentView.addSubview(subTitleLab2)
        contentView.addSubview(subTitleLab3)

        contentView.addSubview(lineView)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab1.snp.bottom).offset(6)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab3.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab2.snp.right).offset(150)
            make.top.equalTo(titleLab1.snp.bottom).offset(6)
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
        
        subTitleLab3.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab3.snp.right).offset(10)
            make.centerY.equalTo(titleLab3)
            make.height.greaterThanOrEqualTo(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 20.0*2.0+6.0+12.0*2.0-1, left: 25, bottom: 0, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
