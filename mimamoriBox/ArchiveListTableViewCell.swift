//
//  ArchiveListTableViewCell.swift
//  mimamoriBox
//
//

import Foundation
import UIKit

class ArchiveListTableViewCell :UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var archiveImage1: UIImageView!
    @IBOutlet weak var archiveImage2: UIImageView!
    @IBOutlet weak var archiveImage3: UIImageView!
    
    @IBOutlet weak var archiveLabel1: UILabel!
    @IBOutlet weak var archiveLabel2: UILabel!
    @IBOutlet weak var archiveLabel3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(archiveByDay :Array<Archive>) {
        
        // 予想時刻があるかどうか取得
        let ud = NSUserDefaults.standardUserDefaults()
        let forecastDate = ud.objectForKey("forecastDate")
        let forecastDate2 = ud.objectForKey("forecastDate2") // ここは削除可能
        
        // 現在時刻と比較
        let now = NSDate()
        let passed = forecastDate!.timeIntervalSinceDate(now)
        let passed2 = forecastDate2!.timeIntervalSinceDate(now) // ここは削除可能
        // 何時間後か求める
        let min = Int(passed / 60)
        let hour = Int(min / 60)
        
        // 何時間後か求める（ここは削除可能)
        let min2 = Int(passed2 / 60)
        let hour2 = Int(min2 / 60)
        
        // ビューのリセット（これがないと表示に不具合
        self.dayLabel.text = ""
        self.archiveImage1.image = UIImage(named: "iconUnChecked")
        self.archiveImage2.image = UIImage(named: "iconUnChecked")
        self.archiveImage3.image = UIImage(named: "iconUnChecked")
        self.archiveLabel1.text = ""
        self.archiveLabel2.text = ""
        self.archiveLabel3.text = ""
        
        
        // 日付のラベルを設定
        self.dayLabel.text = getArchiveDay(archiveByDay[0].createdAt)
        
        let archiveCount = archiveByDay.count
        
        // 期限が切れたアーカイブを判定する処理（汚すぎるので要修正）
        var passedTime = now.timeIntervalSinceDate(archiveByDay[0].createdAt) // 現在時刻との差分を求める
        passedTime = passedTime / ( 60 * 60 )
        if (passedTime > 24) {
            // 一旦全部赤に変える
            self.archiveImage1.image = UIImage(named: "iconWarning")
            self.archiveImage2.image = UIImage(named: "iconWarning")
            self.archiveImage3.image = UIImage(named: "iconWarning")
            for var i = 1; i <= archiveCount; i += 1 {
                if (i == 1) {
                    self.archiveImage1.image = UIImage(named: "iconChecked")
                    self.archiveLabel1.text = getArchiveTime(archiveByDay[0].createdAt)
                } else if (i == 2) {
                    self.archiveImage2.image = UIImage(named: "iconChecked")
                    self.archiveLabel2.text = getArchiveTime(archiveByDay[1].createdAt)
                } else if (i == 3) {
                    self.archiveImage3.image = UIImage(named: "iconChecked")
                    self.archiveLabel3.text = getArchiveTime(archiveByDay[2].createdAt)
                }
            }
            
        } else {
            for var i = 1; i <= archiveCount; i += 1 {
                if (i == 1) {
                    self.archiveImage1.image = UIImage(named: "iconChecked")
                    self.archiveLabel1.text = getArchiveTime(archiveByDay[0].createdAt)
                } else if (i == 2) {
                    self.archiveImage2.image = UIImage(named: "iconChecked")
                    self.archiveLabel2.text = getArchiveTime(archiveByDay[1].createdAt)
                } else if (i == 3) {
                    self.archiveImage3.image = UIImage(named: "iconChecked")
                    self.archiveLabel3.text = getArchiveTime(archiveByDay[2].createdAt)
                }
            }
            
            // 予告時刻のセット
            if (archiveCount == 0) {
                self.archiveLabel1.text = String(hour) + "時間後"
            } else if (archiveCount == 1) {
                self.archiveLabel2.text = String(hour) + "時間後"
            } else if (archiveCount == 2) {
                self.archiveLabel3.text = String(hour2) + "時間後"
            }
        }
        
        
        
    }
    
    // いつアーカイブが作られたかを返す
    func getArchiveTime(createdAt: NSDate) -> String {
        
        let now = NSDate()
        let passedTime = now.timeIntervalSinceDate(createdAt) // 現在時刻との差分を求める
        
        // 差分によって表示を変化
        let min = Int(passedTime / 60)
        if min < 1  { return "1分前" }
        if min < 60 { return String(min) + "分前" }
        
        let hour = Int(min / 60)
        if hour < 24 { return String(hour) + "時間前" }
        
        let day = Int(hour / 24)
        return String(day) + "日前"
        
    }
    
    // NSDateから日付と曜日を返す関数
    func getArchiveDay(createdAt: NSDate) -> String {
        
        let cal: NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let comp: NSDateComponents = cal.components(
            [NSCalendarUnit.Weekday, NSCalendarUnit.Day],
            fromDate: createdAt
        )
        let weekday: Int = comp.weekday
        let weekdaySymbolIndex: Int = weekday - 1
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja")
        
        let weeklyStr = formatter.weekdaySymbols[weekdaySymbolIndex] // -> 日曜日
        let dayStr    = String(comp.day)
        
        let dateStr = dayStr + "日（" + weeklyStr + "）"
        
        
        return dateStr
 
    }
    
}
