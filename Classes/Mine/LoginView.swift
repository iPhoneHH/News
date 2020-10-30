//
//  LoginView.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/19.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginAction: UIButton!

    @IBAction func closeActionEvent(_ sender: UIButton) {
        print("======= Close ========")
    }
   
    @IBAction func loginActionEvent(_ sender: UIButton) {
        print("======= Login ========")
    }
}


// load xib
extension  LoginView {
   
    class func loadFromNib() -> LoginView {
        return Bundle.main.loadNibNamed("LoginView", owner: nil, options: nil)?[0] as! LoginView
    }
    
    
}
