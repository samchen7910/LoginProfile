//
//  UIImageViewEX.swift
//  MachineLogin
//
//  Created by Tran Gia Huy on 11/20/17.
//  Copyright © 2017 HUDU. All rights reserved.
//

import Kingfisher

extension UIImageView {
    
    func downloadFromURL(_ url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url))
    }
}





