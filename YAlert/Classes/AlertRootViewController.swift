//
//  AlertPresentingViewController.swift
//  Pods
//
//  Created by Wo Jun Feng on 7/21/17.
//
//

import UIKit

/**
 The only purpose for this class is to inherit the current status bar style instead of using .default
 */
class AlertRootViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle // Inherit the current status bar style
    }
}
