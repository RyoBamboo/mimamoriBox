//
//  MyRealm.swif.swift
//  mimamoriBox
//
//  すべてのモデルを管理するクラス
//

import Foundation
import RealmSwift

class MyRealm {
    
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
}