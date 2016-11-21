//
//  Archive.swift
//  mimamoriBox
//

import Foundation
import RealmSwift

class Archive: Object {
    
    dynamic var userId: String = ""    // ユーザID
    dynamic var createdAt: NSDate = NSDate() // 作成された日付
    
}