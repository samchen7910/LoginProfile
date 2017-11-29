//
//  ProfileView.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/21/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import UIKit

class ProfileView : UIViewController {
    var emailUser = ""
    var register = Register()
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var smallView: UIView!
    
    @IBOutlet weak var txtOldPW: UITextField!
    
    @IBOutlet weak var txtNewPW: UITextField!
    
    @IBOutlet weak var txtReNewPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.smallView.isHidden = true
        showInfor()
        
    }
    @IBAction func onClickLogout(_ sender: Any) {
        
        USER_DEFAULT.set(false, forKey: "isLogined")
        self.navigationController?.popViewController(animated: true)
        Commons.sharedInstance.showAlertOnViewController(self, message: "Log out success", mainButton: "OK", mainComplete: { (status) in
            Log.debug("Press a button")
        })
        return
    }
    
    @IBAction func onClickChangePW(_ sender: Any) {
        self.smallView.isHidden = false
        
    }

    @IBAction func onClickCancelChangePW(_ sender: Any) {
        self.smallView.isHidden = true
        txtOldPW.text = ""
        txtNewPW.text = ""
        txtReNewPW.text = ""
    }
    
    @IBAction func onClickAgreeChangePW(_ sender: Any) {
        let userArray = register.load()
        
        for i in 0..<userArray.count
        {
            
            if (emailUser == userArray[i].email)
            {
                if (txtOldPW.text != userArray[i].password)
                {
                    Commons.sharedInstance.showAlertOnViewController(self, message: "Password is incorrect", mainButton: "OK", mainComplete: { (status) in
                        Log.error("Press a button")
                    })
                    return
                }
                else
                {
                    if(txtReNewPW.text != txtNewPW.text)
                    {
                        Commons.sharedInstance.showAlertOnViewController(self, message: "New password not match", mainButton: "OK", mainComplete: { (status) in
                            Log.error("Press a button")
                        })
                    }
                    else
                    {
                        userArray[i].password = txtReNewPW.text!
                        Log.debug("\(userArray)")
                        self.register.save(arrUser: userArray)
                        USER_DEFAULT.synchronize()
                        Log.debug("\(userArray[i].password)")
                        self.smallView.isHidden = true
                    }
                }
                
            }
            
        }
        
       
    }
    
    func showInfor() {
        let arrayUser = register.load()
        for i in 0 ..< arrayUser.count
        {
            if(emailUser == arrayUser[i].email)
            {
                lblName.text = arrayUser[i].name
                lblEmail.text = arrayUser[i].email
                lblPhone.text = String(arrayUser[i].phone)
                lblAddress.text = arrayUser[i].address
                Log.debug("Print something")
            }
        }
    }
}

