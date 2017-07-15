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
    }
    
    @IBAction func showAlertButtonTapped(_ sender: Any) {
        let test = YAlert.AlertViewController(bannerImageName: nil, title: nil, message: "hh", button1:"ok", button2: "")
            test.present()
//        let alertVC = AlertViewController(bannerImageName: "banner",
//                                          title: "Hi",
//                                          message: "This is a message",
//                                          button1: "Ok",
//                                          button2: "Cancel")
//        alertVC.delegate = self
//        alertVC.present()
    }
}

extension ViewController: AlertViewControllerDelegate {
    func didTappedPrimaryButton(_ sender: AlertViewController) {
        print("primary button tapped")
    }
    
    func didTappedSecondaryButton(_ sender: AlertViewController) {
        
    }
    
    func didTappedBackground(_ sender: AlertViewController) {
        
    }
}

