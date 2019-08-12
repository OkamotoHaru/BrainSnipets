//
//  SelectWordbookViewController.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/12.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

class SelectWordbookViewController: UIViewController {

    // MARK: ********** 接続 **********
    
    /// ナビゲーションバー
    @IBOutlet weak var navigationBar: UINavigationBar!
    /// スクロールビュー
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: ********** ライフサイクル **********
    
    /// 画面ロードが完了した際に呼ばれます
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        // 単語帳作成
        //makeWordbook()
    }

    /// 画面が表示されそうになった際に呼ばれます
    ///
    /// - Parameter animated: アニメするか
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ステータスバー
        setStatusBarLayout()
        // ナビゲーションバー
        setNavigationBarLayout()
        // 背景色設定
        self.view.backgroundColor = UIColor(hex: BackgroundColor)
        // 単語帳作成
        makeWordbook()
        //
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1000)
    }
    
    // MARK: ********** ステータスバー **********
    
    /// ステータスバーのレイアウトを設定
    func setStatusBarLayout() {
        // ステータスバーの色
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(hex: NavigationColor)
    }
    
    // MARK: ********** ナビゲーションバー **********
    
    /// ナビゲーションバー
    func setNavigationBarLayout() {
        // ナビゲーションバーの色
        navigationBar.backgroundColor = UIColor(hex: NavigationColor)
        // テキスト設定
        navigationBar.setTitle("単語帳リスト")
        // テキストカラー設定
        navigationBar.setTitleColor(UIColor(hex: TextColor))
    }
    
    // MARK: ********** 単語帳 **********
    
    /// 単語帳を作成します
    func makeWordbook(){
        let book = UIView()
        book.backgroundColor = UIColor.red
        //book.translatesAutoresizingMaskIntoConstraints = false
        book.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scrollView.addSubview(book)
        // 上
        book.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        // 左
        book.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        // 右
        book.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        // 高さ
        book.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

