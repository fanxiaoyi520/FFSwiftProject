//
//  FFNavighationController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFNavighationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBar.appearance(whenContainedInInstancesOf: [type(of: self)])
        var dict: [NSAttributedString.Key : Any] = [:]
        if #available(iOS 13.0, *) {
            // iOS 13之后，使用这种方式设置导航栏的相关属性才能正常工作。之前的方法已经失效。
            dict = [NSAttributedString.Key.foregroundColor: Theme.navTitleColor(), NSAttributedString.Key.font: UIFont.fontWithPFSemibold(18)]
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor.secondarySystemGroupedBackground
            navBarAppearance.titleTextAttributes = dict
            navBar.standardAppearance = navBarAppearance
            navBar.scrollEdgeAppearance = navBarAppearance
        } else {
            dict = [NSAttributedString.Key.foregroundColor: Theme.navTitleColor(), NSAttributedString.Key.font: UIFont.fontWithPFSemibold(18)]
            navBar.barTintColor = Theme.whiteColor()
            navBar.titleTextAttributes = dict
        }
        navBar.isTranslucent = false
        navBar.tintColor = Theme.subTitleColor()
    }
}
