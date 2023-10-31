//
//  FFTabBarController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.backgroundColor = UIColor.white 

        addChildViewControllers()
    }
    
    /// 添加子视图控制器
    func addChildViewControllers() {
        setChildViewController(FFHomeListViewController(), title: "首页", imageName: "tabbar_home_normal_", selectImageName: "tabbar_home_select_")
        setChildViewController(FFBillingViewController(), title: "开单", imageName: "tabbar_billing_normal_", selectImageName: "tabbar_billing_select_")
        setChildViewController(FFCheckListViewController(), title: "查单", imageName: "tabbar_checklist_normal_", selectImageName: "tabbar_checklist_select_")
        setChildViewController(FFMineViewController(), title: "我的", imageName: "tabbar_mine_normal_", selectImageName: "tabbar_mine_select_")
    }
    
    /// 初始化子视图控制器
    func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectImageName: String) {
        let image = UIImage(named: imageName)
        let size = CGSize(width: 25, height: 25)

        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { _ in
            image?.draw(in: CGRect(origin: .zero, size: size))
        }
        childController.tabBarItem.image = resizedImage.withRenderingMode(.alwaysOriginal)
        
        let selImage = UIImage(named: selectImageName)
        let selResizedImage = renderer.image { _ in
            selImage?.draw(in: CGRect(origin: .zero, size: size))
        }
        childController.tabBarItem.selectedImage = selResizedImage.withRenderingMode(.alwaysOriginal)
        childController.title = title
        
        // 设置为默认是 title
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:153/255.0, green:153/255.0, blue:153/255.0, alpha:1.00)], for: .normal)
        // 设置选中 title
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:51/255.0, green:51/255.0, blue:51/255.0, alpha:1.00)], for: .selected)
        // 添加导航控制器为 TabBarController 的子控制器
        let nav = FFNavighationController(rootViewController: childController)
        addChild(nav)
    }

}
