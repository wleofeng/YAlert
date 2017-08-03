//
//  AlertView.swift
//  CustomUI
//
//  Created by Wo Jun Feng on 5/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

import UIKit

class AlertView: UIView {
    var backgroundView: UIView = UIView()
    var stackView: UIStackView = UIStackView()
    var effectView: UIVisualEffectView = UIVisualEffectView()
    lazy var bannerImageView: UIImageView = UIImageView()
    lazy var titleTextView: UITextView = UITextView()
    lazy var messageTextView: UITextView = UITextView()
    lazy var primaryButton: UIButton = UIButton(type: .system)
    lazy var secondaryButton: UIButton = UIButton(type: .system)
    
    init(model: Alert) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        config(model)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
        
        setupBackground()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alpha = 0
        stackView.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        
        backgroundView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: UI.margin
            ),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -UI.margin)
            ])
    }
    
    func config(_ model: Alert) {
        // Do all the view setup here
        if let imageName = model.bannerImageName, imageName.isValid {
            setupBanner(imageName)
            stackView.addArrangedSubview(bannerImageView)
        }
        
        if let title = model.title, title.isValid {
            setupTitle(title)
            stackView.addArrangedSubview(titleTextView)
        }
        
        if let message = model.message, message.isValid {
            setupMessage(message)
            stackView.addArrangedSubview(messageTextView)
        }
        
        if let title = model.primaryButtonTitle, title.isValid {
            setupPrimaryButton(title)
            stackView.addArrangedSubview(primaryButton)
        }
        
        if let title = model.secondaryButtonTitle, title.isValid {
            setupSecondaryButton(title)
            stackView.addArrangedSubview(secondaryButton)
        }
    }
}

// MARK: View setup
extension AlertView {
    fileprivate func setupBackground() {
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.backgroundColor = UIColor(red:0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        let blurEffect = UIBlurEffect(style: .dark)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let effectView = UIVisualEffectView(effect: vibrancyEffect)
        effectView.frame = backgroundView.frame
        effectView.alpha = 1.0
        
        backgroundView.addSubview(effectView)
    }
    
    fileprivate func setupBanner(_ bannerImageName: String) {
        guard let image = UIImage(named: bannerImageName) else {
            return
        }
    
        let ratio = (UIScreen.main.bounds.size.width - (UI.margin * 2.0)) / image.size.width
        var bannerImageViewFrame  = bannerImageView.frame
        bannerImageViewFrame.size.height = image.size.height * ratio
        bannerImageViewFrame.size.width = UIScreen.main.bounds.size.width
            - (UI.margin * 2.0)
        
        bannerImageView.image = image
        bannerImageView.backgroundColor = UIColor.white
        bannerImageView.contentMode = UIViewContentMode.scaleAspectFit
        bannerImageView.frame = bannerImageViewFrame
        
        // Corner radius for top corners
        let path = UIBezierPath(roundedRect:bannerImageViewFrame,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 10, height:  0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bannerImageView.layer.mask = maskLayer
        
        // set required size constraints
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.heightAnchor.constraint(equalToConstant: bannerImageViewFrame.height),
            bannerImageView.widthAnchor.constraint(equalToConstant: bannerImageViewFrame.width),
            ])
    }
    
    fileprivate func setupTitle(_ titleText: String) {
        titleTextView.text = titleText
        titleTextView.backgroundColor = UIColor.clear
        titleTextView.isEditable = false
        titleTextView.isSelectable = false
        titleTextView.isScrollEnabled = false
        titleTextView.textAlignment = .center
        titleTextView.textColor = UIColor.black
        titleTextView.font = UIFont.boldSystemFont(ofSize: (titleTextView.font?.pointSize)! + 2)
        titleTextView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
        titleTextView.sizeToFit()
        
        var titleTextViewFrame = titleTextView.frame
        titleTextViewFrame.size.height = titleTextView.contentSize.height
        titleTextView.frame = titleTextViewFrame
    }
    
    fileprivate func setupMessage(_ messageText: String) {
        messageTextView.text = messageText
        messageTextView.backgroundColor = UIColor.clear
        messageTextView.isEditable = false
        messageTextView.isSelectable = false
        messageTextView.isScrollEnabled = false
        messageTextView.textAlignment = .center
        messageTextView.textColor = UIColor.black
        messageTextView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
        messageTextView.sizeToFit()
        
        var textViewFrame = messageTextView.frame
        textViewFrame.size.height = messageTextView.contentSize.height
        messageTextView.frame = textViewFrame
    }
    
    fileprivate func setupPrimaryButton(_ buttonText: String) {
        primaryButton.setTitle(buttonText, for: UIControlState())
        setupCommonButton(primaryButton)
    }
    
    fileprivate func setupSecondaryButton(_ buttonText: String) {
        secondaryButton.setTitle(buttonText, for: UIControlState())
        setupCommonButton(secondaryButton)
    }
    
    fileprivate func setupLineView(for button: UIButton) {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (UI.margin * 2) - 2), // 2 for the white border
            lineView.topAnchor.constraint(equalTo: button.topAnchor),
            lineView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
            ])
    }
    
    fileprivate func setupCommonButton(_ button: UIButton) {
        setupLineView(for: button)
    }
    
    /** 
     This need to be called after viewDidAppear
     Perform all necessary view effects and animations to show Alert view
     */
    func showView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        
        stackView.insertSubview(backgroundView, at: 0)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let borderWidth: CGFloat = 1.0
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -borderWidth),
            backgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: borderWidth),
            backgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -borderWidth),
            backgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: borderWidth)
            ])
        
        backgroundView.layoutIfNeeded() // update background view bounds in order to calculate shadow frame
        
        let shadowFrame = backgroundView.layer.bounds
        let shadowPath = UIBezierPath(rect: shadowFrame).cgPath
        backgroundView.layer.shadowPath = shadowPath
        
        backgroundView.clipsToBounds = false
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0.7)
        backgroundView.layer.shadowOpacity = 1.0
        backgroundView.layer.shadowRadius = 6.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        })
        
        UIView.animate(withDuration: 0.3/1.5, animations: {
            self.stackView.alpha = 1.0
            self.stackView.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        })
    }
}

