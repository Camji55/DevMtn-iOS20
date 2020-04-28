//
//  ViewController.swift
//  Flashlight
//
//  Created by Cameron Ingham on 7/2/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var lightView: UIView!
    @IBOutlet weak var powerImage: UIImageView!
    @IBOutlet weak var tapLabel: UILabel!
    
    var isOn: Bool = false
    let locationX: Float = 0
    let locationY: Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        powerImage.image = powerImage.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        powerImage.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer){
       toggleFlashlight(withOpacity: locationY)
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer){
        let location = recognizer.location(in: view)
        let locationY = (100 * location.y / UIScreen.main.bounds.height)
        lightView.backgroundColor = UIColor(white: 1, alpha: 1-locationY/100)
        if(locationY < 50){
            powerImage.tintColor = UIColor.darkGray
            tapLabel.textColor = UIColor.darkGray
        }
        else {
            powerImage.tintColor = UIColor.white
            tapLabel.textColor = UIColor.white
        }
        if locationY > 0.1 {
            flash(on: true, level: Float(1 - locationY/100))
            tapLabel.text = "Tap anywhere to turn off"
            isOn = true
        }
        else{
            flash(on: false, level: Float(1 - locationY/100))
            tapLabel.text = "Tap anywhere to turn on"
            isOn = false
        }
        
    }
    
    func toggleFlashlight(withOpacity opacity: Float){
        if(isOn){
            powerImage.tintColor = UIColor.white
            lightView.backgroundColor = UIColor.darkGray
            tapLabel.textColor = UIColor.white
            tapLabel.text = "Tap anywhere to turn on"
            UIApplication.shared.statusBarStyle = .lightContent
            flash(on: false, level: 0.0)
            isOn = false
        }
        else{
            powerImage.tintColor = UIColor.darkGray
            lightView.backgroundColor = UIColor.white
            tapLabel.textColor = UIColor.darkGray
            tapLabel.text = "Tap anywhere to turn off"
            UIApplication.shared.statusBarStyle = .default
            flash(on: true, level: 1.0)
            isOn = true
        }
    }
    
    func flash(on: Bool, level: Float) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            return
        }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on == true {
                    try device.setTorchModeOn(level: level)
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Flash could not be used")
            }
        } else {
            print("Flash is not available")
        }
    }
}

