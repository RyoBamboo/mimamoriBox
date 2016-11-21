//
//  DayViewController.swift
//  mimamoriBox
//
//

import Foundation
import UIKit
import RealmSwift

class DayViewController :UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm :Realm = try! Realm() // realmオブジェクト
    var user: User!
    var archives: Results<Archive>!
    
    @IBOutlet weak var archivesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザのアーカイブを取得
        archives = MyRealm.getArchivesByUserId(user.id)
        
        // アーカイブを表示するTableViewの設定
        archivesTableView.delegate = self
        archivesTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = archives!.count / 3
        if (archives!.count % 3 != 0) {
            rowCount = rowCount + 1
        }
        
        return rowCount
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveListTableViewCell") as! ArchiveListTableViewCell
        cell.setCell(archives[indexpath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

