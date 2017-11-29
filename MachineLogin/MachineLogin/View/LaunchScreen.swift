//
//  LaunchScreen.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/29/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import UIKit

class LaunchScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if USER_DEFAULT.bool(forKey: "isLogined") {
            Log.debug("print something")
            let profileView = storyboard?.instantiateViewController(withIdentifier: "viewProfile") as! ProfileView
            profileView.emailUser = USER_DEFAULT.string(forKey: "userEmail")!
            self.navigationController?.pushViewController(profileView, animated: true)
            return
        }
        else
        {
            Log.debug("print something")
            let loginView = storyboard?.instantiateViewController(withIdentifier: "viewLogin") as! LoginView
            self.navigationController?.pushViewController(loginView, animated: true)
            return
        }
    }
    
 
}
