//
//  Register.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/21/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPW: UITextField!
    
    @IBOutlet weak var txtRePW: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func onClickRegistered(_ sender: Any) {
        if ((txtEmail.text?.isEmpty)! || (txtPW.text?.isEmpty)! ||
            (txtRePW.text?.isEmpty)! || (txtName.text?.isEmpty)! ||
            (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)
        {
            Commons.sharedInstance.showAlertOnViewController(self, message: "All fields are required", mainButton: "Accept", mainComplete: { (status) in
                Log.error("Press a button Register on Register Field")
            })
            return
        }
        
        if (txtPW.text != txtRePW.text)
        {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Passwords do not match with with Re-password", mainButton: "Accept", mainComplete:
                { (status) in
                Log.error("Press a button")
                })
        }
        
        guard isValidEmail(testStr: txtEmail.text!) else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Email is not Validated", mainButton: "Accept", mainComplete:
                { (status) in
                    Log.error("Email is not correct")
                })
            return
            }
        
        guard isEmailExist(testEmail: txtEmail.text!) else {
            return
        }
        
        guard let phone = Int(txtPhone.text!) else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Phone is not correct", mainButton: "Accept", mainComplete: { (status) in
                Log.error("Press a button")
            })
            return
            }
        
        var arrUser = self.load()
        arrUser.append(User(email: txtEmail.text!, password: txtPW.text!,
                            phone: phone, address: txtAddress.text!,
                            name: txtName.text!))
        self.save(arrUser: arrUser)
        Log.debug("Save on UserDefault")
        Commons.sharedInstance.showAlertOnViewController(self, message: "The Register is sucessful",
                                                         mainButton: "Accept",mainComplete:
                                                        { (status) in
                                                            Log.debug("Register sucess!!!")
                                                            self.navigationController?.popViewController(animated: true)
                                                        })
        
    }
    
    func load() -> [User] {
        
        var data = USER_DEFAULT.object(forKey: "arrUser") as? Data
        
        if (data == nil)
        { //Check data at first time
            data = Data()
        }
        let arrUser = NSKeyedUnarchiver.unarchiveObject(with: data!)
        
        if let arr = arrUser as? [User] {
            return arr
        }
        return []
    }
    
    func save(arrUser : [User]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: arrUser)
        
        USER_DEFAULT.set(data, forKey: "arrUser")
        USER_DEFAULT.synchronize()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isEmailExist(testEmail: String) -> Bool {
        var bool = true
        let arrUser = self.load()
        for i in 0..<arrUser.count {
            if (testEmail == arrUser[i].email){
                Commons.sharedInstance.showAlertOnViewController(self, message: "Email is existing", mainButton: "Accept", mainComplete: { (status) in
                    bool = false
                    Log.error("Press a button")
                })
            }
        }
        return bool
    }
}
