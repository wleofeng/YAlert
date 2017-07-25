//
//  AlertViewWindow.swift
//  Pods
//
//  Created by Wo Jun Feng on 7/25/17.
//
//

import UIKit

class AlertWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    fileprivate func commonInit() {
        rootViewController = AlertRootViewController()
        windowLevel = UIWindowLevelAlert + 1
        makeKeyAndVisible()
    }
}
