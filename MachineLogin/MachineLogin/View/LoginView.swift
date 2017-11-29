//
//  ViewController.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/20/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginView: UIViewController {

    @IBOutlet weak var txtID: UITextField!
    
    @IBOutlet weak var txtPW: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickToLogin(_ sender: Any) {
        
        let userEmail = txtID.text
        let userPW = txtPW.text
        
        let register = Register()
        let arrayUser = register.load()
        Log.debug("\(arrayUser.count)")
        USER_DEFAULT.set(userEmail, forKey:"userEmail")
        USER_DEFAULT.synchronize()
        
        for i in 0 ..< arrayUser.count
        {
            Log.debug("print something")
            if (userEmail == arrayUser[i].email && userPW == arrayUser[i].password)
            {
                print("something")
                USER_DEFAULT.set(true, forKey: "isLogined")
                USER_DEFAULT.synchronize()
              
                let profileView = storyboard?.instantiateViewController(withIdentifier: "viewProfile") as! ProfileView
                profileView.emailUser = (userEmail)!
                self.navigationController?.pushViewController(profileView, animated: true)
                return
            }
        }
        
        Commons.sharedInstance.showAlertOnViewController(self, message: "Email or Password is wrong", mainButton: "OK", mainComplete: { (status) in
            Log.error("Press a button")
        })
        
    }
    
}

