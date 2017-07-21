//
//  ViewController.swift
//  CustomUI
//
//  Created by Wo Jun Feng on 5/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

import UIKit

@objc public protocol AlertViewControllerDelegate: class {
    @objc optional func didTapPrimaryButton(_ sender: AlertViewController)
    @objc optional func didTapSecondaryButton(_ sender: AlertViewController)
    @objc optional func didTapBackground(_ sender: AlertViewController)
}

open class AlertViewController: UIViewController {
    fileprivate var windowMode: Bool = false
    var alert: Alert
    var alertView: AlertView
    open weak var delegate: AlertViewControllerDelegate?
    open var tag: Int = 0
    
    // Initialization
    init(alert: Alert) {
        self.alert = alert
        self.alertView = AlertView(model: self.alert)

        super.init(nibName: nil, bundle: nil)
    }
    
    public init(bannerImageName: String?, title: String?, message: String?, primaryButtonTitle: String?, secondaryButtonTitle: String?) {
        self.alert = Alert(bannerImageName: bannerImageName, title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
        self.alertView = AlertView(model: self.alert)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(title: String?, message: String?, primaryButtonTitle: String?, secondaryButtonTitle: String?) {
        self.init(bannerImageName: nil, title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
    }

    public convenience init(title: String?, message: String?, primaryButtonTitle: String?) {
        self.init(title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.alert = Alert()
        self.alertView = AlertView(frame: .zero)
        
        super.init(coder: aDecoder)
    }
}

// MARK: View cycle
extension AlertViewController {
    open override func loadView() {
        alertView.primaryButton.addTarget(self, action: #selector(button1Tapped(_:)), for: UIControlEvents.touchUpInside)
        alertView.secondaryButton.addTarget(self, action: #selector(button2Tapped(_:)), for: UIControlEvents.touchUpInside)
        
        let recognizer = UITapGestureRecognizer()
        recognizer.delegate = self
        recognizer.addTarget(self, action: #selector(backgroundTapped(_:)))
        alertView.backgroundView.addGestureRecognizer(recognizer)
        
        view = alertView
    }
}

// MARK: Event handler 
extension AlertViewController {
    func button1Tapped(_ sender: UIButton) {
        dismiss()
        delegate?.didTapPrimaryButton?(self) //completion logic
    }
    
    func button2Tapped(_ sender: UIButton) {
        dismiss()
        delegate?.didTapSecondaryButton?(self) //completion logic
    }
    
    func backgroundTapped(_ sender: UIView) {
        dismiss()
        delegate?.didTapBackground?(self) //completion logic
    }
    
    // Presentation Methods
    open func present() {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            // This is simply doing the same thing as presenting a view controller in container view
            rootVC.addChildViewController(self)
            rootVC.view.addSubview(view)
            rootVC.view.bringSubview(toFront: view)
            view.frame = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds // view should cover the full window/screen
            didMove(toParentViewController: rootVC)
            alertView.showView() // Trigger alert view appearance effects
        } else {
            // An alternative to present via a new window
            windowMode = true
            
            let window: UIWindow
            if UIApplication.shared.keyWindow?.tag == 9999 {
                window = UIApplication.shared.keyWindow!
            } else {
                window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = UIViewController()
                window.windowLevel = UIWindowLevelAlert + 1
                window.tag = 9999
                window.makeKeyAndVisible()
            }
        
            // add slight delay to avoid a view distortion issue
            let delayInSeconds: Double = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                window.rootViewController?.present(self, animated: false, completion: { 
                    self.alertView.showView() // Trigger alert view appearance effects
                })
            }
        }
    }
    
    func dismiss() {
        if !windowMode {
            willMove(toParentViewController: nil)
            view.removeFromSuperview()
            removeFromParentViewController()
        } else {
            windowMode = false
            dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: UITapGestureRecognizerDelegate
extension AlertViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if alertView.stackView.bounds.contains(touch.location(in: alertView.stackView)) {
            return false
        }
        
        return true;
    }
}
