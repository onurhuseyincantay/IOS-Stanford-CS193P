//
//  ViewController.swift
//  First
//
//  Created by onur hüseyin çantay on 26/04/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction func TouchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
        
            let textCurrentlyInDisplay = display.text!
            display.text!=textCurrentlyInDisplay+digit
            
        }else{
            display.text=digit
            userIsInTheMiddleOfTyping = true
        }
        print("\(digit)TouchDigit was Called")
        
    }
    var displayValue: Double {
        get{
        return Double(display.text!)!
        }
        set{
        display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
        brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{
        displayValue = result
        }}}
       
        

  
    

