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
    var primaryButtonTitle: String?
    var secondaryButtonTitle: String?
    
    init() { }
    
    init(bannerImageName: String?, title: String?, message: String?, primaryButtonTitle: String?, secondaryButtonTitle: String?) {
        self.bannerImageName = bannerImageName ?? ""
        self.title = title ?? ""
        self.message = message ?? ""
        self.primaryButtonTitle = primaryButtonTitle ?? ""
        self.secondaryButtonTitle = secondaryButtonTitle ?? ""
    }
}
