//
//  WordbookEditViewController.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/14.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

class WordbookEditViewController: UIViewController {

    // MARK: ********** イニシャライザ **********
    
    /// 画面ロードが完了した際に呼ばれます
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーレイアウト設定
        setNavigtationBarLayout()
    }
    
    // MARK: ********** ナビゲーションバー **********
    
    /// ナビゲーションバー
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    /// ナビゲーションバーのレイアウトを設定します
    private func setNavigtationBarLayout() {
        navigationBar.setTitle("英検２級")
        // 影もいるので空画像設定
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    /// ナビゲーションバーの戻るが押された際に呼ばれます
    @IBAction func tappedBack(_ sender: Any) {
        print("tappedBack()")
        // 前画面に戻る
        self.dismiss(animated: true, completion: {})
    }
    
}
