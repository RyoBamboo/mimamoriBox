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
        
        let archiveCount = archiveByDay.count
        for var i = 1; i <= archiveCount; i += 1 {
            if (i == 1) {
                self.archiveImage1.image = UIImage(named: "iconChecked")
            } else if (i == 2) {
                self.archiveImage2.image = UIImage(named: "iconChecked")
            } else if (i == 3) {
                self.archiveImage3.image = UIImage(named: "iconChecked")
            }
        }
        
    }
    
}
