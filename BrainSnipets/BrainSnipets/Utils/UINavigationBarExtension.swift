//
//  UINavigationBarExtension.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/12.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /// タイトルテキストを設定します
    ///
    /// - Parameter title: テキスト
    func setTitle (_ title:String) {
        self.topItem?.title = title
    }
    
    func setTitleColor(_ color: UIColor) {
        // テキスト属性設定
        self.titleTextAttributes = [
            .foregroundColor: color
        ]
    }
}
