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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // ユーザ詳細画面から戻ってきた時にセルの選択を解除
        if let indexPathForSelectedRow = userListTableView.indexPathForSelectedRow {
            userListTableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)

        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*-------------------------------
         * デバッグ用の設定
         *-----------------------------*/
        // 予測時刻を2016/11/26/16:00と2016/11/26/20:00に設定
        let testFormatter = NSDateFormatter()
        testFormatter.locale = NSLocale(localeIdentifier:"ja_JP")
        testFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let forecastDate = testFormatter.dateFromString("2016/11/26 16:00:00")
        let forecastDate2 = testFormatter.dateFromString("2016/11/26 20:00:00") // これは削除可能
        
        // UserDefaultに保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(forecastDate, forKey: "forecastDate")
        ud.setObject(forecastDate2, forKey: "forecastDate2") // これは削除可能
        ud.synchronize()
        
        /*
        deleteAll()
        createSampleUser()
        createSampleArchive("1")
        createSampleArchive2("2")
        createSampleArchive2("3")
        createSampleArchive("4")
 */
        
        
        
        // すべてのユーザを取得
        userList = realm.objects(User)
        
        // 画面の初期化
        self.userListTableView.delegate = self
        self.userListTableView.dataSource = self
        self.userListTableView.separatorColor = UIColor.clearColor()
        
        // UINavigationControllerの背景を透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        // UINavigationControllerのアイコンの色を白にする
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*---------------------------------------
    * TableViewのDelegateとDataSource
    *--------------------------------------*/
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserListTableViewCell") as! UserListTableViewCell
        cell.setCell(userList[indexpath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 画面遷移の準備
        let selectedUser = userList[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("UserDetailViewController") as! UserDetailViewController
        vc.user = selectedUser // 選択されたユーザをセット
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*---------------------------------------
    * デバッグ用関数
    *--------------------------------------*/
    
    // サンプルユーザを作成する関数
    func createSampleUser() {
        
        MyRealm.createUser("1", name: "豊川幸枝", imgPath: "1.jpg", address: "和歌山県岩出市山里164-4ヒイラギ岩出102号", phoneNumber: "0736610408", birthDate: "1920年11月23日", createdAt: NSDate())
        MyRealm.createUser("2", name: "杉村正次", imgPath: "2.jpg", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", birthDate: "1923年3月10日", createdAt: NSDate(timeIntervalSinceNow: 9 * 60 * 60))
        MyRealm.createUser("3", name: "山本久雄", imgPath: "3.jpg", address: "徳島県名賀群豊崎町122", phoneNumber: "0736610408", birthDate: "1924年10月1日", createdAt: NSDate(timeIntervalSinceNow: 15 * 60 * 60))
        MyRealm.createUser("4", name: "重盛多美", imgPath: "4.jpg", address: "和歌山県和歌山市十三番丁30", phoneNumber: "0736610408", birthDate: "1922年5月19日", createdAt: NSDate(timeIntervalSinceNow: 25 * 60 * 60))
    }
    
    // サンプルアーカイブを作成する関数2
    func createSampleArchive(userId: String) {
        let now = NSDate()
        
        for i in 0 ..< 7 {
            let day = Double(i)
            
            if ( i == 0) {
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -6 * 60 * 60))
                //MyRealm.createArchive(userId, createdAt: now)
            } else {
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 24 * 60 * 60))
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 26 * 60 * 60))
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 28  * 60 * 60))
            }
        }
        
    }
    
    // サンプルアーカイブを作成する関数2
    func createSampleArchive2(userId: String) {
        let now = NSDate()
        
        for i in 0 ..< 7 {
            let day = Double(i)
            
            if ( i == 0) {
                MyRealm.createArchive(userId, createdAt: now)
            } else {
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 24 * 60 * 60))
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 26 * 60 * 60))
                MyRealm.createArchive(userId, createdAt: NSDate(timeIntervalSinceNow: -day * 28  * 60 * 60))
            }
        }
        
    }
    
    // すべてのデータを削除
    func deleteAll() {
        try! realm.write() {
            realm.deleteAll()
        }
    }
    

}

