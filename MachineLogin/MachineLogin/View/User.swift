//
//  User.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/21/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import Foundation

class User : NSObject, NSCoding {
    
    var email:String = ""
    var password:String = ""
    var phone:Int = 0
    var address:String = ""
    var name:String = ""
    
    init(email:String,password:String,phone:Int,address:String,name:String) {
        self.email = email
        self.password = password
        self.phone = phone
        self.address = address
        self.name = name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email, forKey: PREF_EMAIL)
        aCoder.encode(self.password,forKey: PREF_PASSWORD)
        aCoder.encode(self.name, forKey: PREF_NAME)
        aCoder.encode(self.phone, forKey: PREF_PHONE)
        aCoder.encode(self.address, forKey: PREF_ADDRESS)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: PREF_EMAIL) as! String
        self.password = aDecoder.decodeObject(forKey: PREF_PASSWORD) as! String
        self.phone = aDecoder.decodeInteger(forKey: PREF_PHONE)
        self.address = aDecoder.decodeObject(forKey: PREF_ADDRESS) as! String
        self.name = aDecoder.decodeObject(forKey: PREF_NAME) as! String
    }
}
