//
//  MyRealm.swif.swift
//  mimamoriBox
//
//  すべてのモデルを管理するクラス
//

import Foundation
import RealmSwift

class MyRealm {
    
    /*
    class func createUser(name: String, imgPath: String, address: String, phoneNumber: String, birthDate: String,createdAt: NSDate) {
        
        let user = User()
        user.id          = NSUUID().UUIDString
        user.name        = name
        user.imgPath     = imgPath
        user.address     = address
        user.phoneNumber = phoneNumber
        user.birthDate   = birthDate
        user.createdAt   = createdAt
        
        let realm = try! Realm()
        try! realm.write{ realm.add(user) }
    }
    */
    
    class func createUser(id: String, name: String, imgPath: String, address: String, phoneNumber: String, birthDate: String,createdAt: NSDate) {
        
        let user = User()
        user.id          = id
        user.name        = name
        user.imgPath     = imgPath
        user.address     = address
        user.phoneNumber = phoneNumber
        user.birthDate   = birthDate
        user.createdAt   = createdAt
        
        let realm = try! Realm()
        try! realm.write{ realm.add(user) }
    }
    
    class func createArchive(userId: String, createdAt: NSDate) {
        
        let archive = Archive()
        archive.userId = userId
        archive.createdAt = createdAt
        
        let realm = try! Realm()
        try! realm.write{ realm.add(archive) }
    }
    
    class func getArchivesByUserId(userId: String) -> Results<Archive> {
        
        let realm = try! Realm()
        let archives = realm.objects(Archive).filter("userId = %@", userId)
        
        return archives
    }
    
    class func sortArchivesByDay(archives: Results<Archive>) -> Array<Array<Archive>> {
        var archivesByDay: Array<Array<Archive>> = []
        
        let archivesCount = archives.count
        
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        var tmpCreatedAt = format.stringFromDate(archives[0].createdAt) // 日付を整形
        
        var tmpArchivesArray: [Archive] = []
        for i in 0 ..< archivesCount {
            let createdAt = format.stringFromDate(archives[i].createdAt) // 日付を整形
            if (createdAt == tmpCreatedAt) {
                tmpArchivesArray.append(archives[i])
            } else {
                // 日付が変わったらachivesByDay配列に追加して、tmpArchivesArrayを初期化
                archivesByDay.append(tmpArchivesArray) // 返り値の配列に追加
                tmpCreatedAt = createdAt               // 日付を初期化
                tmpArchivesArray = []                  // 一時保存用配列を初期化
                tmpArchivesArray.append(archives[i])   // 新しい日付のアーカイブを保存
            }
        }
        
        
        return archivesByDay
    }
}