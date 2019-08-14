//
//  WordbooksViewController.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/12.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

class WordbooksViewController: UIViewController {

    // MARK: ********** 接続 **********
    
    /// スクロールビュー
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: ********** ライフサイクル **********
    
    /// 画面ロードが完了した際に呼ばれます
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // ナビゲーションバー
        setNavigationBarLayout()
        // 単語帳作成
        for _ in 0..<2 {
            makeWordbook()
        }
    }
    
    /// 画面が表示されそうになった際に呼ばれます
    ///
    /// - Parameter animated: アニメするか
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: ********** ナビゲーションバー **********
    
    /// ナビゲーションバー
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    /// ナビゲーションバーのレイアウトを設定します
    private func setNavigationBarLayout() {
        // 影もいるので空画像設定
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    /// ナビゲーションバーのメニューアイコンをタップした際に呼ばれます
    ///
    /// - Parameter sender: UIBarButtonItem
    @IBAction func tappedMenu(_ sender: Any) {
        print("tappedMenu")
        makeAletDialog()
    }
    
    // MARK: ********** 単語帳 **********
    
    /// 単語帳リスト
    private var wordbooks: [UIView] = []
    
    /// 単語帳の高さ
    private var WordbookHeight: CGFloat = 60.0
    
    /// 単語帳を作成します
    func makeWordbook(){
        // 単語帳大枠
        let book = UIView(frame: CGRect.zero)
        // 背景色設定
        book.backgroundColor = UIColor.white
        // アルファ
        book.alpha = 0.8
        // 角丸設定
        book.layer.cornerRadius = 5
        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        book.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        book.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        book.layer.shadowOpacity = 0.6
        // 影をぼかし
        book.layer.shadowRadius = 4
        // タグ設定
        book.tag = wordbooks.count
        // 制約有効
        book.translatesAutoresizingMaskIntoConstraints = false
        // タッチ判定追加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedWordbook(_:)))
        book.addGestureRecognizer(tapGesture)
        // 追加
        scrollView.addSubview(book)
        // 制約設定
        if (wordbooks.count <= 0) {
            book.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        } else {
            book.topAnchor.constraint(equalTo: wordbooks[wordbooks.count - 1].bottomAnchor, constant: 15).isActive = true
        }
        book.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        book.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        book.heightAnchor.constraint(equalToConstant: WordbookHeight).isActive = true
        
        // タイトルラベル生成
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "英検２級"
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: WordbookHeight/3)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        book.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: book.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: book.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: book.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: book.heightAnchor, multiplier: 0.5).isActive = true
        
        // メニューボタン生成
        let menuButton = UIButton(type: .system)
        let menuImage = UIImage(named: "menu") ?? UIImage()
        menuButton.setImage(menuImage, for: .normal)
        menuButton.tintColor = UIColor.gray
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(tappedWordbookMenu), for: .touchUpInside)
        book.addSubview(menuButton)
        menuButton.topAnchor.constraint(equalTo: book.topAnchor, constant: 5).isActive = true
        menuButton.rightAnchor.constraint(equalTo: book.rightAnchor, constant: -5).isActive = true
        menuButton.heightAnchor.constraint(equalTo: book.heightAnchor, multiplier: 0.2).isActive = true
        menuButton.widthAnchor.constraint(equalTo: menuButton.heightAnchor, multiplier: 1).isActive = true
        
        // テスト推奨度
        let recommendTitleLabel = UILabel(frame: CGRect.zero)
        recommendTitleLabel.text = "テスト推奨度："
        recommendTitleLabel.textColor = .black
        recommendTitleLabel.font = UIFont.systemFont(ofSize: WordbookHeight/4)
        recommendTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        book.addSubview(recommendTitleLabel)
        recommendTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        recommendTitleLabel.leftAnchor.constraint(equalTo: book.leftAnchor, constant: 15).isActive = true
        recommendTitleLabel.widthAnchor.constraint(lessThanOrEqualTo: book.widthAnchor, multiplier: 0.3).isActive = true
        recommendTitleLabel.bottomAnchor.constraint(equalTo: book.bottomAnchor, constant: -5).isActive = true
        
        // 推奨度アイコン
        let recommendLevelParent = UIView(frame: CGRect.zero)
        recommendLevelParent.translatesAutoresizingMaskIntoConstraints = false
        book.addSubview(recommendLevelParent)
        recommendLevelParent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        recommendLevelParent.leftAnchor.constraint(equalTo: recommendTitleLabel.rightAnchor, constant: 0).isActive = true
        recommendLevelParent.widthAnchor.constraint(lessThanOrEqualTo: book.widthAnchor, multiplier: 0.4).isActive = true
        recommendLevelParent.bottomAnchor.constraint(equalTo: book.bottomAnchor, constant: -5).isActive = true
        var tmpStar = UIImageView()
        for i in 0..<10 {
            let starImage = UIImage(named: "star") ?? UIImage()
            let star = UIImageView(image: starImage)
            star.translatesAutoresizingMaskIntoConstraints = false
            recommendLevelParent.addSubview(star)
            star.topAnchor.constraint(equalTo: recommendLevelParent.topAnchor, constant: 0).isActive = true
            if i > 0 {
                star.leftAnchor.constraint(equalTo: tmpStar.rightAnchor, constant: 0).isActive = true
            } else {
                star.leftAnchor.constraint(equalTo: recommendLevelParent.leftAnchor, constant: 0).isActive = true
            }
            star.bottomAnchor.constraint(equalTo: recommendLevelParent.bottomAnchor, constant: 0).isActive = true
            star.widthAnchor.constraint(equalTo: recommendLevelParent.widthAnchor, multiplier: 1/10).isActive = true
            star.heightAnchor.constraint(equalTo: star.heightAnchor).isActive = true
            tmpStar = star
        }
        
        // リストに追加
        wordbooks.append(book)
    }
    
    /// 単語帳をタップした際に呼ばれます
    @objc func tappedWordbook(_ sender: UITapGestureRecognizer) {
        guard let book = sender.view else {
            return;
        }
        print("tappedWordbook() tag:\(book.tag)")
    }
    
    /// 単語帳のメニューをタップした際に呼ばれます
    @objc func tappedWordbookMenu(){
        print("tappedWordbookMenu()")
        // 遷移
        let storyboard = UIStoryboard(name: "WordbookEditViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WordbookEditViewController")
        present(vc, animated: true, completion: {})
    }
    
    // MARK: ********** アラートコントローラー **********
    
    /// アラートコントローラー
    private var alertController: UIAlertController = UIAlertController()
    
    /// アラートコントローラーを生成します
    private func makeAletDialog() {
        // 生成
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // アクション設定
        var action = UIAlertAction(title: "新規作成", style: .default, handler: { _ in
            print("新規作成")
        })
        alertController.addAction(action)
        action = UIAlertAction(title: "一括削除", style: .default, handler: { _ in
            print("一括削除")
        })
        alertController.addAction(action)
        action = UIAlertAction(title: "キャンセル", style: .cancel, handler: { _ in
            print("キャンセル")
        })
        alertController.addAction(action)
        // 表示
        self .present(alertController, animated: true, completion: {})
    }
}
