//
//  Constants.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/20/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import UIKit

let DEBUG = true

let USER_DEFAULT: UserDefaults = UserDefaults.standard

let APP_DELEGATE: AppDelegate = UIApplication.shared.delegate as! AppDelegate

let SCREEN_SIZE: CGSize = UIScreen.main.bounds.size

let IS_IPHONE: Bool = UIDevice.current.model == "iPhone"

var IOS: Int {
    get {
        let currentOS = UIDevice.current.systemVersion
        let index = currentOS.index(of: ".") ?? currentOS.endIndex
        return Int(currentOS[..<index])!
    }
}

let PREF_EMAIL = "email"
let PREF_PASSWORD = "password"
let PREF_PHONE = "phone"
let PREF_NAME = "name"
let PREF_ADDRESS = "address"
