//
//  UserListTableViewCell.swift
//  mimamoriBox
//
//

import Foundation
import UIKit

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
        
    }
}
