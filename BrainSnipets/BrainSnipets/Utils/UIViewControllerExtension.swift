//
//  UIViewControllerExtension.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/15.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// ストーリーボード名からインスタンスを取得します
    ///
    /// - Parameter storyboardName: ストーリーボード名
    static public func getViewController(storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardName)
        return vc
    }
}
