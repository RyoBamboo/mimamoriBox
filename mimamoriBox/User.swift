//
//  User.swift
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var id: String = "" // ユーザID
    dynamic var name: String = "" // ユーザ名
    dynamic var address: String = "" // 住所
    dynamic var img: String = ""
    dynamic var phoneNumber:Int = 0 // 電話番号
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
