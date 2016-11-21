//
//  ArchiveListTableViewCell.swift
//  mimamoriBox
//
//

import Foundation
import UIKit

class ArchiveListTableViewCell :UITableViewCell {
    
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
        
        // ビューのリセット（これがないと表示に不具合
        self.archiveImage1.image = UIImage(named: "iconUnChecked")
        self.archiveImage2.image = UIImage(named: "iconUnChecked")
        self.archiveImage3.image = UIImage(named: "iconUnChecked")
        self.archiveLabel1.text = ""
        self.archiveLabel2.text = ""
        self.archiveLabel3.text = ""
        
        let archiveCount = archiveByDay.count
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
    
}
