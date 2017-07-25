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
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle // Inherit the current status bar style
    }
    
    var alertView: AlertView // Main view
    open var tag: Int = 0 // Identifier
    open weak var delegate: AlertViewControllerDelegate?
    
    // Initialization
    init(alert: Alert) {
        self.alertView = AlertView(model: alert)

        super.init(nibName: nil, bundle: nil)
    }
    
    public init(bannerImageName: String?, title: String?, message: String?, primaryButtonTitle: String?, secondaryButtonTitle: String?) {
        let alert = Alert(bannerImageName: bannerImageName, title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
        self.alertView = AlertView(model: alert)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(title: String?, message: String?, primaryButtonTitle: String?, secondaryButtonTitle: String?) {
        self.init(bannerImageName: nil, title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
    }

    public convenience init(title: String?, message: String?, primaryButtonTitle: String?) {
        self.init(title: title, message: message, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.alertView = AlertView(frame: .zero)
        
        super.init(coder: aDecoder)
    }
}

// MARK: View cycle
extension AlertViewController {
    open override func loadView() {
        super.loadView()
        
        alertView.primaryButton.addTarget(self, action: #selector(primaryButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        alertView.secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        let recognizer = UITapGestureRecognizer()
        recognizer.delegate = self
        recognizer.addTarget(self, action: #selector(backgroundTapped(_:)))
        alertView.backgroundView.addGestureRecognizer(recognizer)
        
        view = alertView // AlertView is the view of this VC
    }
}

// MARK: Event handler 
extension AlertViewController {
    func primaryButtonTapped(_ sender: UIButton) {
        dismiss()
        delegate?.didTapPrimaryButton?(self) //completion logic
    }
    
    func secondaryButtonTapped(_ sender: UIButton) {
        dismiss()
        delegate?.didTapSecondaryButton?(self) //completion logic
    }
    
    func backgroundTapped(_ sender: UIView) {
        dismiss()
        delegate?.didTapBackground?(self) //completion logic
    }
    
    // Presentation Methods
    open func present() {
            var window: UIWindow
            if let alertWindow = UIApplication.shared.keyWindow as? AlertWindow {
                window = alertWindow
            } else {
                window = AlertWindow()
            }
        
            // add slight delay to avoid a view distortion issue
            let delayInSeconds: Double = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                window.rootViewController?.present(self, animated: false, completion: {
                    self.alertView.showView() // Trigger alert view appearance effects
                })
            }
    }
    
    func dismiss() {
        dismiss(animated: false, completion: nil)
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
