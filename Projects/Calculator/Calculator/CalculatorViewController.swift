//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Cameron Ingham on 8/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    let calculator = Calculator()
    
    // MARK: - Views
    lazy var zeroButton = UIButton()
    lazy var periodButton = UIButton()
    lazy var equalsButton = UIButton()
    lazy var oneButton = UIButton()
    lazy var twoButton = UIButton()
    lazy var threeButton = UIButton()
    lazy var addButton = UIButton()
    lazy var fourButton = UIButton()
    lazy var fiveButton = UIButton()
    lazy var sixButton = UIButton()
    lazy var minusButton = UIButton()
    lazy var sevenButton = UIButton()
    lazy var eightButton = UIButton()
    lazy var nineButton = UIButton()
    lazy var multiplyButton = UIButton()
    lazy var clearButton = UIButton()
    lazy var leftParenthesisButton = UIButton()
    lazy var rightParenthesisButton = UIButton()
    lazy var divideButton = UIButton()
    
    lazy var resultsLabel = UILabel()

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Functions
    func setupViews() {
        view.backgroundColor = UIColor.white
        
        // Row 1
        view.addSubview(zeroButton)
        zeroButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: zeroButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: zeroButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: zeroButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: zeroButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        zeroButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(periodButton)
        periodButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        periodButton.setTitle("·", for: .normal)
        periodButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        periodButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: periodButton, attribute: .leading, relatedBy: .equal, toItem: zeroButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: periodButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: periodButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: periodButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        periodButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(equalsButton)
        equalsButton.backgroundColor = UIColor(red:0.39, green:0.81, blue:0.79, alpha:1.0)
        equalsButton.setTitle("=", for: .normal)
        equalsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: equalsButton, attribute: .leading, relatedBy: .equal, toItem: periodButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: equalsButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: equalsButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: equalsButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        equalsButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        // Row 2
        view.addSubview(oneButton)
        oneButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        oneButton.setTitle("1", for: .normal)
        oneButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        oneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: oneButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: oneButton, attribute: .bottom, relatedBy: .equal, toItem: zeroButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: oneButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: oneButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        oneButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(twoButton)
        twoButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        twoButton.setTitle("2", for: .normal)
        twoButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        twoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: twoButton, attribute: .leading, relatedBy: .equal, toItem: oneButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: twoButton, attribute: .bottom, relatedBy: .equal, toItem: periodButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: twoButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: twoButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        twoButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(threeButton)
        threeButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        threeButton.setTitle("3", for: .normal)
        threeButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        threeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: threeButton, attribute: .leading, relatedBy: .equal, toItem: twoButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: threeButton, attribute: .bottom, relatedBy: .equal, toItem: equalsButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: threeButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: threeButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        threeButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: addButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .bottom, relatedBy: .equal, toItem: equalsButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        addButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    
        // Row 3
        view.addSubview(fourButton)
        fourButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        fourButton.setTitle("4", for: .normal)
        fourButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        fourButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: fourButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourButton, attribute: .bottom, relatedBy: .equal, toItem: oneButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: fourButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        fourButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(fiveButton)
        fiveButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        fiveButton.setTitle("5", for: .normal)
        fiveButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        fiveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: fiveButton, attribute: .leading, relatedBy: .equal, toItem: fourButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fiveButton, attribute: .bottom, relatedBy: .equal, toItem: twoButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fiveButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: fiveButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        fiveButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(sixButton)
        sixButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        sixButton.setTitle("6", for: .normal)
        sixButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        sixButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: sixButton, attribute: .leading, relatedBy: .equal, toItem: fiveButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sixButton, attribute: .bottom, relatedBy: .equal, toItem: threeButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sixButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: sixButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        sixButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(minusButton)
        minusButton.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: minusButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .bottom, relatedBy: .equal, toItem: addButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        minusButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        // Row 4
        view.addSubview(sevenButton)
        sevenButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        sevenButton.setTitle("7", for: .normal)
        sevenButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        sevenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: sevenButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sevenButton, attribute: .bottom, relatedBy: .equal, toItem: fourButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sevenButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: sevenButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        sevenButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(eightButton)
        eightButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        eightButton.setTitle("8", for: .normal)
        eightButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        eightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: eightButton, attribute: .leading, relatedBy: .equal, toItem: sevenButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: eightButton, attribute: .bottom, relatedBy: .equal, toItem: fiveButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: eightButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: eightButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        eightButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(nineButton)
        nineButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        nineButton.setTitle("9", for: .normal)
        nineButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        nineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: nineButton, attribute: .leading, relatedBy: .equal, toItem: eightButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nineButton, attribute: .bottom, relatedBy: .equal, toItem: sixButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nineButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: nineButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        nineButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(multiplyButton)
        multiplyButton.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        multiplyButton.setTitle("x", for: .normal)
        multiplyButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        multiplyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: multiplyButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: multiplyButton, attribute: .bottom, relatedBy: .equal, toItem: minusButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: multiplyButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: multiplyButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        multiplyButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        // Row 5
        view.addSubview(clearButton)
        clearButton.backgroundColor = UIColor(red:0.97, green:0.53, blue:0.53, alpha:1.0)
        clearButton.setTitle("C", for: .normal)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: clearButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: clearButton, attribute: .bottom, relatedBy: .equal, toItem: sevenButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: clearButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: clearButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        clearButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(leftParenthesisButton)
        leftParenthesisButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        leftParenthesisButton.setTitle("(", for: .normal)
        leftParenthesisButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        leftParenthesisButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: leftParenthesisButton, attribute: .leading, relatedBy: .equal, toItem: clearButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: leftParenthesisButton, attribute: .bottom, relatedBy: .equal, toItem: eightButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: leftParenthesisButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: leftParenthesisButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        leftParenthesisButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

        view.addSubview(rightParenthesisButton)
        rightParenthesisButton.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        rightParenthesisButton.setTitle(")", for: .normal)
        rightParenthesisButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        rightParenthesisButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: rightParenthesisButton, attribute: .leading, relatedBy: .equal, toItem: leftParenthesisButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rightParenthesisButton, attribute: .bottom, relatedBy: .equal, toItem: nineButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rightParenthesisButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: rightParenthesisButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        rightParenthesisButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(divideButton)
        divideButton.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        divideButton.setTitle("/", for: .normal)
        divideButton.setTitleColor(UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0), for: .normal)
        divideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: divideButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: divideButton, attribute: .bottom, relatedBy: .equal, toItem: multiplyButton, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: divideButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: divideButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.125, constant: 0).isActive = true
        divideButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(resultsLabel)
        resultsLabel.font = UIFont.systemFont(ofSize: 40.0)
        resultsLabel.textColor = UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)
        resultsLabel.textAlignment = .right
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: resultsLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: resultsLabel, attribute: .bottom, relatedBy: .equal, toItem: clearButton, attribute: .top, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: resultsLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: resultsLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16).isActive = true
    }
    
    @objc func buttonTapped(sender: UIButton) {
        guard let title = sender.titleLabel?.text else {return}
        switch title {
        case "=":
            if let text = resultsLabel.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty {
                let results = calculator.calculate(expressionString: resultsLabel.text)
                resultsLabel.text = results == nil ? "Error" : "\(String(format: "%g", results!))"
            }
        case "C":
            resultsLabel.text = ""
        case "+", "-", "/", "x", "(", ")":
            resultsLabel.text = (resultsLabel.text ?? "") + " \(title) ".replacingOccurrences(of: "·", with: ".")
        default:
            resultsLabel.text = (resultsLabel.text ?? "") + "\(title)".replacingOccurrences(of: "·", with: ".")
        }
    }

}
