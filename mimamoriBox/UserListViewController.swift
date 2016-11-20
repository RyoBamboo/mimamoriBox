//
//  ViewController.swift
//  mimamoriBox
//
//

import UIKit
import RealmSwift

class UserListViewController: UIViewController {
    
    let realm :Realm = try! Realm()
    let userList :Array<User> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        MyRealm.createUser("豊川幸枝", imgPath: "1.jpg.", address: "和歌山県岩出市山里164-4ヒイラギ岩出102号", phoneNumber: "0736610408", createdAt: NSDate())
        MyRealm.createUser("杉村正次", imgPath: "2.jpg.", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 9 * 60 * 60))
        MyRealm.createUser("山本久雄", imgPath: "3.jpg.", address: "徳島県名賀群豊崎町122", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 15 * 60 * 60))
        MyRealm.createUser("重盛多美", imgPath: "4.jpg.", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 25 * 60 * 60))
        
         */
        
        /*
        try! realm.write() {
            realm.deleteAll()
        }
         */
        // すべてのユーザを取得
        let userList = Array(realm.objects(User))
        print(userList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

