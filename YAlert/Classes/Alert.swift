//
//  Alert.swift
//  CustomUI
//
//  Created by Wo Jun Feng on 5/31/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

import UIKit

class Alert {
    var bannerImageName: String?
    var title: String?
    var message: String?
    var button1: String?
    var button2: String?
    
    init() { }
    
    init(bannerImageName: String?, title: String?, message: String?, button1: String?, button2: String?) {
        self.bannerImageName = bannerImageName ?? ""
        self.title = title ?? ""
        self.message = message ?? ""
        self.button1 = button1 ?? ""
        self.button2 = button2 ?? ""
    }
}
