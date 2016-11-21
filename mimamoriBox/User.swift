//
//  User.swift
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var id: String = ""         // ユーザID
    dynamic var name: String = ""       // ユーザ名
    dynamic var imgPath: String = ""    // ユーザの画像
    dynamic var address: String = ""    // 住所
    dynamic var phoneNumber: String = ""     // 電話番号
    dynamic var createdAt: NSDate = NSDate() // 作成された日付
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
