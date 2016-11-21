//
//  ProfileViewController.swift
//  mimamoriBox
//
//

import Foundation
import UIKit

class ProfileViewController :UIViewController {
    
    var user: User!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面の初期化
        addressLabel.text = user.address
        phoneLabel.text = user.phoneNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

