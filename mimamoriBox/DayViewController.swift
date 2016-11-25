//
//  DayViewController.swift
//  mimamoriBox
//
//

import Foundation
import UIKit
import RealmSwift
import CocoaMQTT

class DayViewController :UIViewController, UITableViewDelegate, UITableViewDataSource, CocoaMQTTDelegate {
    
    let realm :Realm = try! Realm() // realmオブジェクト
    var user: User!
    var archives: Results<Archive>!
    var archivesByDay: Array<Array<Archive>>!
    
    @IBOutlet weak var archivesTableView: UITableView!
    
    // MQTTの設定
    var mqtt: CocoaMQTT!
    private struct MqttConstants {
        static let AppID    = "mimamoriApp"
        static let ClientId = MqttConstants.AppID
        static let HostName = "m11.cloudmqtt.com"
        static let Port: UInt16 = 15908
        static let UserName = "rzfucdfi"
        static let PassWord = "BjtZ0FUigzEI"
        static let Topic = "lux"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザのアーカイブを取得
        archives = MyRealm.getArchivesByUserId(user.id)
        // アーカイブを日毎にグループ化
        archivesByDay = MyRealm.sortArchivesByDay(archives)
        
        // アーカイブを表示するTableViewの設定
        archivesTableView.delegate = self
        archivesTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        mqtt = CocoaMQTT(clientId: MqttConstants.ClientId, host: MqttConstants.HostName, port: MqttConstants.Port)
        mqtt.username = MqttConstants.UserName
        mqtt.password = MqttConstants.PassWord
        mqtt.delegate = self
        mqtt.keepAlive = 60
        
        mqtt.connect()
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
    
    
    func mqtt(matt: CocoaMQTT, didConnect host: String, port: Int) {
        print("didConnect")
    }
    
    
    func mqtt(matt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("didConnectAck")
        if ack == .ACCEPT {
            self.mqtt.subscribe(MqttConstants.Topic, qos: .QOS0)
        }
    }
    
    
    func mqtt(mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("didReceivedMessage: \(message.string!) with id \(id)")
        
        let archive: Archive = Archive()
        archive.userId = "1"
        archive.createdAt = NSDate()
        archivesByDay[0].append(archive)
        
        self.archivesTableView.reloadData()
        
        /*------------------------------------
         * 予測時刻を解析
         *----------------------------------*/
        // Pythonからの時刻を整形(yyyy/mm/dd 1100 => yyyy/mm/dd/ 11:00)
        var predictTime = message.string!
        let insertIdx = predictTime.endIndex.advancedBy(-2)
        predictTime.insert(":", atIndex: insertIdx)
        
        // 整形した時刻の文字列からNSDateを生成
        let testFormatter = NSDateFormatter()
        //ロケールを設定する。
        testFormatter.locale = NSLocale(localeIdentifier:"ja_JP")
        //フォーマットを設定する。
        testFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        //文字列をNSDateに変換する。
        let forecastDate = testFormatter.dateFromString(predictTime + ":00")
        
        // UserDefaultに保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(forecastDate, forKey: "forecastDate")
        ud.synchronize()
        
    }
    
    
    func mqtt(mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16 ) {
    }
    
    
    func mqtt(mqtt: CocoaMQTT, didPublishAck id: UInt16) {
    }
    
    
    func mqtt(mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("didSubscribeTopic to \(topic)")
    }
    
    
    func mqtt(mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("didUnsubscribeTopic to \(topic)")
    }
    
    
    func mqttDidPing(mqtt: CocoaMQTT) {
        print("didPing")
    }
    
    
    func mqttDidReceivePong(mqtt: CocoaMQTT) {
        _console("didReceivePong")
    }
    
    
    func mqttDidDisconnect(mqtt: CocoaMQTT, withError err: NSError?) {
        _console("mqttDidDisconnect")
    }
    
    
    func _console(info: String) {
        print("Delegate: \(info)")
    }
    
    
}








