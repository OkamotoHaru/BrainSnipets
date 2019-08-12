//
//  UIApplicationExtension.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/12.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// ステータスバー
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
