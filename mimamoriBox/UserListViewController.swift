//
//  ViewController.swift
//  mimamoriBox
//
//

import UIKit
import RealmSwift

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm :Realm = try! Realm() // realmオブジェクト
    var userList: Results<User>!  // 全ユーザー

    
    @IBOutlet weak var userListTableView: UITableView! // ユーザリストを表示するテーブルビュー
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        MyRealm.createUser("豊川幸枝", imgPath: "1.jpg", address: "和歌山県岩出市山里164-4ヒイラギ岩出102号", phoneNumber: "0736610408", createdAt: NSDate())
        MyRealm.createUser("杉村正次", imgPath: "2.jpg", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 9 * 60 * 60))
        MyRealm.createUser("山本久雄", imgPath: "3.jpg", address: "徳島県名賀群豊崎町122", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 15 * 60 * 60))
        MyRealm.createUser("重盛多美", imgPath: "4.jpg", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", createdAt: NSDate(timeIntervalSinceNow: 25 * 60 * 60))
        
         */
        
        /*
        try! realm.write() {
            realm.deleteAll()
        }
         */
        
        // すべてのユーザを取得
        userList = realm.objects(User)
        print(userList)
        
        // 画面の初期化
        self.userListTableView.delegate = self
        self.userListTableView.dataSource = self
        self.userListTableView.separatorColor = UIColor.clearColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*---------------------------------------
    * TableViewのDelegateとDataSource
    *--------------------------------------*/
    /*
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
 */
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(userList.count)
        return userList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
        //let cell: UserListTableViewCell = UserListTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UserListTableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("UserListTableViewCell") as! UserListTableViewCell

        
        
        print(userList[indexpath.row])
        cell.setCell(userList[indexpath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(userList[indexPath.row])
    }
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell: UserListTableViewCell = tableView.dequeueReusableCellWithIdentifier("UserListTableViewCell", forIndexPath: indexPath) as! UserListTableViewCell
        
        
        print(userList[index.Path.row
])
        cell.setCell(userList[indexPath.row])
        
        return cell
    }
 */

}

