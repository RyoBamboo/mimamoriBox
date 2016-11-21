//
//  UserDetailViewController.swift
//  mimamoriBox
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User! // リストで選択されたユーザ
    
    @IBOutlet weak var thumbnail: UserImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面の初期化、テーブルビュー選択時にuser変数が渡ってくる
        viewInit()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画面の初期化
    func viewInit() {
        self.thumbnail?.sd_setImageWithURL(NSURL(string: "http://okame.prodrb.com/img/" + user.imgPath))
        self.userNameLabel.text = user.name
    }
    
    

}
