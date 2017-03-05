//
//  CustomUINavigation.swift
//  List do
//
//  Created by Doãn Tuấn on 3/3/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation
import UIKit
class CustomCheckListUINavigation: UINavigationController{
    
    override func viewDidAppear(_ animated: Bool) {
        
        // custom background color and tint-text color
        self.navigationBar.barTintColor = UIColor(colorLiteralRed: 105/255, green: 210/255, blue: 231/255, alpha: 1.0)
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        super.viewDidAppear(animated)
        }
}

