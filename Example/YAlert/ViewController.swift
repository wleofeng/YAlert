//
//  ViewController.swift
//  YAlert
//
//  Created by wleofeng@gmail.com on 07/14/2017.
//  Copyright (c) 2017 wleofeng@gmail.com. All rights reserved.
//

import UIKit
import YAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertVC = AlertViewController(bannerImageName: "banner",
                                          title: "Alert #1",
                                          message: "This is a message",
                                          primaryButtonTitle: "Ok",
                                          secondaryButtonTitle: "Cancel")
        alertVC.tag = 1000
        alertVC.delegate = self
        alertVC.present()
    }
    
    @IBAction func showAlertButtonTapped(_ sender: Any) {
        let alertVC = AlertViewController(bannerImageName: "banner",
                                          title: "Are you sure you want to log out?",
                                          message: "If you sign out of your account, all of your photos will be removed from this iPhone.",
                                          primaryButtonTitle: "Ok",
                                          secondaryButtonTitle: "Cancel")
        alertVC.tag = 2000
        alertVC.delegate = self
        alertVC.present()
    }
}

extension ViewController: AlertViewControllerDelegate {
    func didTapPrimaryButton(_ sender: AlertViewController) {
        switch sender.tag {
        case 1000:
            print("1000")
        case 2000:
            print("2000")
        default:
            print("no tag")
        }
        
        print("primary button tapped")
    }
    
    func didTapSecondaryButton(_ sender: AlertViewController) {
        print("secondary button tapped")
    }
    
    func didTapBackground(_ sender: AlertViewController) {
        print("background tapped")
    }
}

