//
//  Notification.swift
//  mimamoriBox
//
//

import Foundation
import UIKit

public class NotificationManager: NSObject {
    
    func setNotification(
        fireDate fireDate: NSDate? = nil,
                 timeZone: NSTimeZone? = nil,
                 repeatInterval: NSCalendarUnit = NSCalendarUnit.init(rawValue: 0),
                 repeatCalendar: NSCalendar? = nil,
                 alertAction: String? = nil,
                 alertBody: String? = nil,
                 alertTitle: String? = nil,
                 hasAction: Bool = true,
                 applicationIconBadgeNumber: Int = 0,
                 soundName: String? = nil,
                 userInfo: NSDictionary? = nil)
    {
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
}