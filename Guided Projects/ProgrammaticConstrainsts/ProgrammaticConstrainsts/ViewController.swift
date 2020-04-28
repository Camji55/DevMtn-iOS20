//
//  ViewController.swift
//  ProgrammaticConstrainsts
//
//  Created by Cameron Ingham on 8/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    lazy var topLeftButton = UIButton()
    lazy var topRightButton = UIButton()
    lazy var bottomLeftButton = UIButton()
    lazy var bottomRightButton = UIButton()
    
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Enums
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Functions
    func setupViews() {
        view.addSubview(topLeftButton)
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topLeftButton.backgroundColor = UIColor(red:0.97, green:0.53, blue:0.53, alpha:1.0)
        NSLayoutConstraint(item: topLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        topLeftButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        topLeftButton.addTarget(self, action: #selector(shake(sender:)), for: .touchDragExit)
        
        view.addSubview(topRightButton)
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.backgroundColor = UIColor(red:0.95, green:0.85, blue:0.62, alpha:1.0)
        NSLayoutConstraint(item: topRightButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        topRightButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(shake(sender:)), for: .touchDragExit)
        
        view.addSubview(bottomLeftButton)
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.backgroundColor = UIColor(red:0.39, green:0.81, blue:0.79, alpha:1.0)
        NSLayoutConstraint(item: bottomLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        bottomLeftButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(shake(sender:)), for: .touchDragExit)
        
        view.addSubview(bottomRightButton)
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.backgroundColor = UIColor(red:0.63, green:0.84, blue:0.96, alpha:1.0)
        NSLayoutConstraint(item: bottomRightButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        bottomRightButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        bottomRightButton.addTarget(self, action: #selector(shake(sender:)), for: .touchDragExit)
    }
    
    @objc func changeColors() {
        let topLeftColor = topLeftButton.backgroundColor
        let topRightColor = topRightButton.backgroundColor
        let bottomLeftColor = bottomLeftButton.backgroundColor
        let bottomRightColor = bottomRightButton.backgroundColor
        
        UIView.animate(withDuration: 0.15) {
            self.topLeftButton.backgroundColor = bottomLeftColor
            self.topRightButton.backgroundColor = topLeftColor
            self.bottomLeftButton.backgroundColor = bottomRightColor
            self.bottomRightButton.backgroundColor = topRightColor
        }
    }
    
    @objc func shake(sender: UIButton) {
        view.bringSubviewToFront(sender)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [
            sender.frame.origin.x + sender.frame.width / 2,
            sender.frame.origin.x + sender.frame.width / 2 - 15,
            sender.frame.origin.x + sender.frame.width / 2,
            sender.frame.origin.x + sender.frame.width / 2 + 15,
            sender.frame.origin.x + sender.frame.width / 2,
            sender.frame.origin.x + sender.frame.width / 2 - 15,
            sender.frame.origin.x + sender.frame.width / 2,
            sender.frame.origin.x + sender.frame.width / 2 + 15,
            sender.frame.origin.x + sender.frame.width / 2
        ]
        animation.keyTimes = [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0]
        animation.duration = 0.35
        animation.repeatCount = 0
        
        sender.layer.add(animation, forKey: "shake")
    }

}
