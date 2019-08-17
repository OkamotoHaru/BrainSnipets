//
//  WordbookViewController.swift
//  BrainSnipets
//
//  Created by masato on 2019/08/15.
//  Copyright © 2019年 FreeNerdLaughed. All rights reserved.
//

import UIKit

class WordbookViewController: UIViewController, UITabBarDelegate {

    // MARK: ********** 参照用メンバ **********
    
    /// スクロールビュー
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: ********** イニシャライザ **********
    
    /// 画面ロードが完了した際に呼ばれます
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーレイアウト設定
        setNavigationBar()
        // タブバーレイアウト設定
        setTabBarLayout()
        // 単語設定
        makeWords()
    }
    
    // MARK: ********** ナビゲーションバー **********

    // ナビゲーションバー
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    /// ナビゲーションバーのレイアウトを設定します
    private func setNavigationBar() {
        // 影もいるので空画像設定
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    /// 戻るボタンをタップした際に呼ばれます
    ///
    /// - Parameter sender: ボタン
    @IBAction func tappedBack(_ sender: Any) {
        print("tappedBack")
        self.dismiss(animated: true, completion: {})
    }
    
    // MARK: ********** タブバー **********
    
    /// タブバー
    @IBOutlet weak var tabBar: UITabBar!
    
    /// タブバーのレイアウトを設定します
    private func setTabBarLayout() {
        tabBar.delegate = self
    }
    
    /// タブバーのアイテムをタップした際に呼ばれます
    ///
    /// - Parameters:
    ///   - tabBar: タップしたアイテムが所属するタブバー
    ///   - item: タップしたアイテム
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("didSelect\(item)")
    }
    
    // MARK: ********** 単語 **********
    
    /// 単語
    private var words: [UIView] = []
    /// 単語帳の高さ
    private let WordHeight: CGFloat = 60.0
    /// 王冠の数
    private let CrownNum: Int = 5
    
    /// 単語を設定します
    private func makeWords() {
        for _ in 0..<2 {
            makeWord()
        }
    }
    
    /// 単語を設定します
    private func makeWord() {
        // 単語帳大枠
        let word = UIView(frame: CGRect.zero)
        // 背景色設定
        word.backgroundColor = UIColor.white
        // アルファ
        word.alpha = 0.8
        // 角丸設定
        word.layer.cornerRadius = 5
        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        word.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        word.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        word.layer.shadowOpacity = 0.6
        // 影をぼかし
        word.layer.shadowRadius = 4
        // タグ設定
        word.tag = words.count
        // 制約有効
        word.translatesAutoresizingMaskIntoConstraints = false
        // タッチ判定追加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedWord(_:)))
        word.addGestureRecognizer(tapGesture)
        // 追加
        scrollView.addSubview(word)
        // 制約設定
        if (words.count <= 0) {
            word.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        } else {
            word.topAnchor.constraint(equalTo: words[words.count - 1].bottomAnchor, constant: 15).isActive = true
        }
        word.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        word.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        word.heightAnchor.constraint(equalToConstant: WordHeight).isActive = true
        // リストに追加
        words.append(word)
        
        // タイトルラベル生成
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "malnutrition"
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: WordHeight/3)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        word.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: word.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: word.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: word.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: word.heightAnchor, multiplier: 0.5).isActive = true
        
        // メニューボタン生成
        let menuButton = UIButton(type: .system)
        let menuImage = UIImage(named: "menu") ?? UIImage()
        menuButton.setImage(menuImage, for: .normal)
        menuButton.tintColor = UIColor.gray
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(tappedWordMenu), for: .touchUpInside)
        word.addSubview(menuButton)
        menuButton.topAnchor.constraint(equalTo: word.topAnchor, constant: 5).isActive = true
        menuButton.rightAnchor.constraint(equalTo: word.rightAnchor, constant: -5).isActive = true
        menuButton.heightAnchor.constraint(equalTo: word.heightAnchor, multiplier: 0.2).isActive = true
        menuButton.widthAnchor.constraint(equalTo: menuButton.heightAnchor, multiplier: 1).isActive = true
        
        // テスト推奨度
        let recommendTitleLabel = UILabel(frame: CGRect.zero)
        recommendTitleLabel.text = "栄養失調"
        recommendTitleLabel.textColor = .black
        recommendTitleLabel.font = UIFont.systemFont(ofSize: WordHeight/4)
        recommendTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        word.addSubview(recommendTitleLabel)
        recommendTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        recommendTitleLabel.leftAnchor.constraint(equalTo: word.leftAnchor, constant: 15).isActive = true
        recommendTitleLabel.widthAnchor.constraint(lessThanOrEqualTo: word.widthAnchor, multiplier: 0.7).isActive = true
        recommendTitleLabel.bottomAnchor.constraint(equalTo: word.bottomAnchor, constant: -5).isActive = true
        
        // 王冠アイコン
        let recommendLevelParent = UIView(frame: CGRect.zero)
        recommendLevelParent.translatesAutoresizingMaskIntoConstraints = false
        word.addSubview(recommendLevelParent)
        recommendLevelParent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        recommendLevelParent.leftAnchor.constraint(greaterThanOrEqualTo: recommendTitleLabel.rightAnchor, constant: 0).isActive = true
        recommendLevelParent.widthAnchor.constraint(equalTo: recommendLevelParent.heightAnchor, multiplier: CGFloat(CrownNum)).isActive = true
        recommendLevelParent.rightAnchor.constraint(equalTo: word.rightAnchor, constant: -5).isActive = true
        recommendLevelParent.bottomAnchor.constraint(equalTo: word.bottomAnchor, constant: -5).isActive = true
        
        var tmpStar = UIImageView()
        for i in 0..<CrownNum {
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
            star.widthAnchor.constraint(equalTo: recommendLevelParent.widthAnchor, multiplier: 1/CGFloat(CrownNum)).isActive = true
            star.heightAnchor.constraint(equalTo: star.widthAnchor).isActive = true
            tmpStar = star
        }
    }
    
    /// 単語をタップした際に呼ばれます
    @objc func tappedWord(_ sender: UITapGestureRecognizer) {
        guard let word = sender.view else {
            return;
        }
        print("tappedWordbook() tag:\(word.tag)")
        // 遷移
//        let vc = UIViewController.getViewController(storyboardName: "WordbookViewController")
//        present(vc, animated: true, completion: {})
    }
    
    /// 単語帳のメニューをタップした際に呼ばれます
    @objc func tappedWordMenu(){
        print("tappedWordbookMenu()")
        // 遷移
//        let vc = UIViewController.getViewController(storyboardName: "WordbookEditViewController")
//        present(vc, animated: true, completion: {})
    }
    
    // MARK: ********** 追加ボタン **********
    
    /// 追加ボタンをタップした際に呼ばれます
    ///
    /// - Parameter sender: ボタン
    @IBAction func tappedAdd(_ sender: Any) {
        print("tappedAdd")
    }
}
