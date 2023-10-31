//
//  FFHomeTableViewCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    // 标题标签
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // 子标题标签
    let subTitleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    var item: ItemList? {
        didSet {
            guard let item = item else { return }
            titleLab.text = item.title
            subTitleLab.text = item.value
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab)
        
        // 添加子标题标签
        contentView.addSubview(subTitleLab)
        
        contentView.addSubview(lineView)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.centerY.equalTo(contentView)
        }
        
        // 设置子标题标签约束（靠右边距 25，并垂直居中）
        subTitleLab.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.centerY.equalTo(contentView)
        }
        
        lineView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 25, bottom: 59.5, right: 0))
        }        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
