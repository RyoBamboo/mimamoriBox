//
//  UserDetailViewController.swift
//  mimamoriBox
//

import UIKit
import PageMenu

class UserDetailViewController: UIViewController {
    
    var user: User! // リストで選択されたユーザ
    
    // PageMenu関係
    var controllerArray: [UIViewController] = [] // PageMeneで使用するViewControllerの配列
    var pageMenu: CAPSPageMenu?
    var profileViewController: ProfileViewController!
    var dayViewController: DayViewController!
    @IBOutlet weak var pageMenuView: UIView! // PageMenuを貼り付けるView
    
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
        
        /*-------------------------------------
        * PageMenuの設定
        *------------------------------------*/
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("Profile") as! ProfileViewController
        profileViewController.user = user
        
        dayViewController = storyboard.instantiateViewControllerWithIdentifier("Day") as! DayViewController
        dayViewController.user = user
        
        profileViewController.title = "プロフィール"
        dayViewController.title = "見守り状況"
        controllerArray.append(dayViewController)
        controllerArray.append(profileViewController)
        let font:UIFont = UIFont(name:"HiraKakuProN-W6",size:15)!
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.hexStr("#ffffff", alpha: 1.0)),
            .UnselectedMenuItemLabelColor(UIColor.hexStr("#5d5d5d", alpha: 1.0)),
            .SelectedMenuItemLabelColor(UIColor.hexStr("#58aea0", alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.hexStr("#58aea0", alpha: 1.0)),
            .MenuItemSeparatorWidth(4.3),
            .MenuItemSeparatorColor(UIColor.clearColor()),
            .UseMenuLikeSegmentedControl(true),
            .MenuHeight(40.0),
            .MenuItemFont(font),
            ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.pageMenuView.addSubview(pageMenu!.view)
        
    }
    
    @IBAction func callToUser(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + user.phoneNumber)!)
    }
    

}
