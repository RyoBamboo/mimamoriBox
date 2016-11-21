//
//  UserListTableViewCell.swift
//  mimamoriBox
//
//

import Foundation
import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UserImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(user :User) {
        self.nameLabel?.text = user.name
        self.addressLabel?.text = user.address
        self.thumbnail?.sd_setImageWithURL(NSURL(string: "http://okame.prodrb.com/img/" + user.imgPath))

    }
}
