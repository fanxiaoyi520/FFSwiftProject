//
//  FFHeaderView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/11/1.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class FFHeaderView : UITableViewHeaderFooterView {
    
    let bgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setup_header")
        return imageView
    }()
    
    let headerImageView : UIImageView = {
        let imageView = UIImageView()
        //let url = URL(string: "https://example.com/image.png")
        //imageView.kf.setImage(with: url)
        return imageView
    }()
    
    let titleLab : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.fontWithPFRegular(15)
        label.textColor = UIColor.white
        label.text = "姓名:\(FFUserManager.shared.currentUser?.userName ?? "default")"
        return label
    }()
    
    let phoneLab : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontWithPFRegular(13)
        label.textColor = UIColor.white
        label.text = "手机号:\(FFUserManager.shared.currentUser?.phone ?? "120")"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(bgImageView)
        contentView.addSubview(headerImageView)
        contentView.addSubview(titleLab)
        contentView.addSubview(phoneLab)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        headerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalTo(-12)
            make.left.equalTo(25)
            make.width.greaterThanOrEqualTo(50);
        }
        
        phoneLab.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(titleLab)
            make.left.equalTo(titleLab.snp.right).offset(20)
            make.right.equalTo(-25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
