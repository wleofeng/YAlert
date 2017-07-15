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
    lazy var button1: UIButton = UIButton(type: UIButtonType.system)
    lazy var button2: UIButton = UIButton(type: UIButtonType.system)
    
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
        
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.alignment = UIStackViewAlignment.center
        stackView.distribution = UIStackViewDistribution.fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alpha = 0
        stackView.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        
        backgroundView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.margin
            ),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Constants.margin)
            ])
    }
    
    func config(_ model: Alert) {
        // Do all the view setup here
        if let banner = model.bannerImageName, banner.isValid {
            setupBanner(banner)
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
        
        if let button = model.button1, button.isValid {
            setupButton1(button)
            stackView.addArrangedSubview(button1)
        }
        
        if let button = model.button2, button.isValid {
            setupButton2(button)
            stackView.addArrangedSubview(button2)
        }
    }
}

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
        let image = UIImage(imageLiteralResourceName: bannerImageName)
        let ratio = (UIScreen.main.bounds.size.width - (Constants.margin * 2.0)) / image.size.width
        var bannerImageViewFrame  = bannerImageView.frame
        bannerImageViewFrame.size.height = image.size.height * ratio
        bannerImageViewFrame.size.width = UIScreen.main.bounds.size.width
            - (Constants.margin * 2.0)
        
        bannerImageView.image = image
        bannerImageView.backgroundColor = UIColor.black
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
    
    fileprivate func setupButton1(_ buttonText: String) {
        button1.setTitle(buttonText, for: UIControlState())
        setupCommonButton(button1)
    }
    
    fileprivate func setupButton2(_ buttonText: String) {
        button2.setTitle(buttonText, for: UIControlState())
        setupCommonButton(button2)
    }
    
    fileprivate func setupCommonButton(_ button: UIButton) {
        button.backgroundColor = UIColor.clear
    }
    
    // This need to be called after viewDidAppear
    func setupStackViewEffects() {
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

