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
    var archivesByDay: Array<Array<Archive>>!
    
    @IBOutlet weak var archivesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザのアーカイブを取得
        archives = MyRealm.getArchivesByUserId(user.id)
        // アーカイブを日毎にグループ化
        archivesByDay = MyRealm.sortArchivesByDay(archives)
        
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
        
        return archivesByDay.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveListTableViewCell") as! ArchiveListTableViewCell
        cell.setCell(archivesByDay[indexpath.row])
        
        return cell
    }
    
    
    
    
    
}

