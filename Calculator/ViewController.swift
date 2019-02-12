//
//  ViewController.swift
//  Calculator
//
//  Created by Developer on 12/13/18.
//  Copyright © 2018 Brandon Channell. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let MAX_NUMBERS:Int = 10
    let MAX_NUMBER:Double = 9999999999
    let MIN_NUMBER:Double = 0.00000001
    
    var numberCurrent:Double = 0
    var numberFirst:Double = 0
    var numberSecond:Double = 0
    var numberMemory:Double = 0
    var decimalState:Bool = false
    var mathState:Bool = false
    var equalsState:Bool = false
    var operation:String = ""

    @IBOutlet weak var label: UILabel!
    
    // Resets the calculator
    @IBAction func clear(_ sender: UIButton)
    {
        numberCurrent = 0
        numberFirst = 0
        numberSecond = 0
        decimalState = false
        mathState = false
        equalsState = false
        operation = ""
        label.text = "0"
    }

    // A number button was pressed
    @IBAction func numbers(_ sender: UIButton)
    {
        if (mathState || label.text == "0") {
            decimalState = false
            mathState = false
            label.text = String(sender.tag)
            numberCurrent = Double(label.text!)!
        } else if (label.text!.count < MAX_NUMBERS) {
            label.text! += String(sender.tag)
            numberCurrent = Double(label.text!)!
        }
    }
    
    // The decimal button was pressed
    @IBAction func decimal(_ sender: UIButton)
    {
        if (mathState || label.text == "0") {
            decimalState = true
            mathState = false
            label.text = "0."
            numberCurrent = Double(label.text!)!
        } else if (!decimalState && label.text!.count < MAX_NUMBERS) {
            decimalState = true
            label.text! += "."
            numberCurrent = Double(label.text!)!
        }
    }
    
    // The negate button was pressed
    @IBAction func negate(_ sender: UIButton)
    {
        numberCurrent *= -1
        if (label.text!.prefix(1) == "-") {
            label.text = String(label.text!.dropFirst())
        } else {
            label.text = "-" + label.text!
        }
    }
    
    // The percent button was pressed
    @IBAction func percent(_ sender: UIButton)
    {
        numberCurrent /= 100;
        mathState = true
        display(number: numberCurrent)
    }
    
    // The sqaure root button was pressed
    @IBAction func squareRoot(_ sender: UIButton)
    {
        numberCurrent = numberCurrent.squareRoot()
        mathState = true
        display(number: numberCurrent)
    }
    
    // The memory clear button was pressed
    @IBAction func memoryClear(_ sender: UIButton)
    {
        numberMemory = 0
    }
    
    // The memory add button was pressed
    @IBAction func memoryAdd(_ sender: UIButton)
    {
        numberMemory += numberCurrent
    }
    
    // The memory subtract button was pressed
    @IBAction func memorySubtract(_ sender: UIButton)
    {
        numberMemory -= numberCurrent
    }
    
    // The memory recall button was pressed
    @IBAction func memoryRecall(_ sender: UIButton)
    {
        numberCurrent = numberMemory
        display(number: numberMemory)
    }
    
    // The add button was pressed
    @IBAction func add(_ sender: UIButton)
    {
        numberFirst = numberCurrent
        operation = "+"
        equalsState = false
        mathState = true
    }
    
    // The subtract button was pressed
    @IBAction func subtract(_ sender: UIButton)
    {
        numberFirst = numberCurrent
        operation = "-"
        equalsState = false
        mathState = true
    }
    
    // The multiply button was pressed
    @IBAction func multiply(_ sender: UIButton)
    {
        numberFirst = numberCurrent
        operation = "x"
        equalsState = false
        mathState = true
    }
    
    // The divide button was pressed
    @IBAction func divide(_ sender: UIButton)
    {
        numberFirst = numberCurrent
        operation = "÷"
        equalsState = false
        mathState = true
    }
    
    // The equals button was pressed
    @IBAction func equals(_ sender: UIButton)
    {
        if (equalsState) {
            numberFirst = numberCurrent
        } else {
            numberSecond = numberCurrent
        }
        
        if (operation != "") {
            solve()
            equalsState = true
            mathState = true
        }
    }
    
    // Performs the stored operation
    func solve()
    {
        switch (operation) {
            case "+":
                numberFirst += numberSecond
            case "-":
                numberFirst -= numberSecond
            case "x":
                numberFirst *= numberSecond
            case "÷":
                numberFirst /= numberSecond
            default:
                return
        }
        
        numberCurrent = numberFirst
        display(number: numberCurrent)
    }
    
    // formats and displays the current number
    func display(number: Double)
    {
        // update the decimal state
        decimalState = number.truncatingRemainder(dividingBy: 1) != 0 ? true : false
        
        let n = number.decimal
        
        if (n.count > 100) {
            label.text = "Error"
        } else if (number == 0) {
            label.text = "0"
        } else if (abs(number) < MIN_NUMBER) {
            label.text = Double(n)!.scientific
        } else if (abs(number) > MAX_NUMBER) {
            label.text = Double(n)!.scientific
        } else if (n.count > MAX_NUMBERS) {
            let rounded = Double(n)!.rounded
            let len = number >= 0 ? MAX_NUMBERS : MAX_NUMBERS + 1
            let number = rounded.prefix(len)
            label.text = Double(number)!.decimal
        } else {
            label.text = n
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
