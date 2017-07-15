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
        let alertVC = AlertViewController(bannerImageName: "banner",
                                          title: "Title",
                                          message: "This is a message",
                                          button1: "Ok",
                                          button2: "Cancel")
        alertVC.delegate = self
        alertVC.present()
    }
}

extension ViewController: AlertViewControllerDelegate {
    func didTapPrimaryButton(_ sender: AlertViewController) {
        print("primary button tapped")
    }
    
    func didTapSecondaryButton(_ sender: AlertViewController) {
        print("secondary button tapped")
    }
    
    func didTapBackground(_ sender: AlertViewController) {
        print("background tapped")
    }
}

