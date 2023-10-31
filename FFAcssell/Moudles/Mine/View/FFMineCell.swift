//
//  FFMineCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/9.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFMineCell: UITableViewCell {
    private var labelImageView: UIImageView!
    private var titleLab: UILabel!
    private var subTitleLab: UILabel!
    private var lineView: UIView!
    
    var isHiddenLineView: Bool = false {
        didSet {
            lineView.isHidden = isHiddenLineView
        }
    }
    
    var model: Mine? {
        didSet {
            guard let model = model else { return }
            titleLab.text = model.title
            labelImageView.image = UIImage(named: model.imageStr ?? "defaultLogo")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        labelImageView = UIImageView()
        
        titleLab = UILabel()
        titleLab.numberOfLines = 0
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = .black
        titleLab.text = "测试"
        
        subTitleLab = UILabel()
        subTitleLab.numberOfLines = 0
        subTitleLab.font = UIFont.systemFont(ofSize: 14)
        subTitleLab.textColor = .gray
        subTitleLab.textAlignment = .right
        
        lineView = UIView()
        lineView.backgroundColor = .lightGray
        
        contentView.addSubview(labelImageView)
        contentView.addSubview(titleLab)
        contentView.addSubview(lineView)
        contentView.addSubview(subTitleLab)
    }
    
    private func addConstraints() {
        labelImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        subTitleLab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 19),
            labelImageView.widthAnchor.constraint(equalToConstant: 25),
            labelImageView.heightAnchor.constraint(equalToConstant: 25),
            
            titleLab.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLab.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 51.5),
            titleLab.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            titleLab.heightAnchor.constraint(greaterThanOrEqualToConstant: 22),
            
            lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            lineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -69.5),
            lineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            subTitleLab.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subTitleLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            subTitleLab.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            subTitleLab.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
    }
}
