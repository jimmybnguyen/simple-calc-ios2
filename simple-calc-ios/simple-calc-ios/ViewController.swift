//
//  ViewController.swift
//  simple-calc-ios
//
//  Created by Jimmy Nguyen on 10/24/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var results: UILabel!
    
    var num1 = Double()
    var num2 = Double()
    var operation = ""
    var operationSelected = false
    var decSelected = false;
    var expression = [Double]()
    var history = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyControllerView = segue.destination as! HistoryViewController
        historyControllerView.history = self.history
    }
    
    func updateExpression() {
        expression.append(Double(results.text!)!)
        results.text = ""
    }

    @IBAction func clearPressed(_ sender: UIButton) {
        results.text = ""
        clearCalc()
    }
    
    func clearCalc() {
        num1 = 0.0
        num2 = 0.0
        operation = ""
        decSelected = false;
        operationSelected = false;
        expression = [Double]()
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        if (operationSelected) {
            results.text = ""
            operationSelected = false
        }
        if (sender.titleLabel!.text! == ".") {
            decSelected = true
        }
        results.text = results.text! + sender.titleLabel!.text!
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        if (results.text != "" && !operationSelected) {
            num1 = Double(results.text!)!
            results.text = sender.titleLabel!.text!
            operation = sender.titleLabel!.text!
            operationSelected = true
        }
    }
    
    @IBAction func countPressed(_ sender: UIButton) {
        if (results.text != "" && !operationSelected) {
            operation = "count"
            updateExpression()
        }
    }
    
    @IBAction func avgPressed(_ sender: UIButton) {
        if (results.text != "" && !operationSelected) {
            operation = "average"
            updateExpression()
        }
    }
    
    @IBAction func factPressed(_ sender: UIButton) {
        if (results.text != "" && !operationSelected && !decSelected) {
            var total = 1
            let limit = Int(results.text!)!
            for i in 1...limit {
                total = total * i
            }
            results.text = String(total)
            history.append("Factorial of \(limit): \(results.text!)")
        } else {
            results.text = "Error!"
        }
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        if (results.text != "" && !operationSelected) {
            num2 = Double(results.text!)!
            switch operation {
                case "+":
                    results.text = String(num1 + num2)
                    history.append("\(num1) + \(num2) = \(results.text!)")
                case "-":
                    results.text = String(num1 - num2)
                    history.append("\(num1) - \(num2) = \(results.text!)")
                case "x":
                    results.text = String(num1 * num2)
                    history.append("\(num1) x \(num2) = \(results.text!)")
                case "/":
                    results.text = String(num1 / num2)
                    history.append("\(num1) / \(num2) = \(results.text!)")
                case "%":
                    results.text = String(num1.truncatingRemainder(dividingBy: num2))
                    history.append("\(num1) % \(num2) = \(results.text!)")
                case "count":
                    updateExpression()
                    results.text = String(expression.count)
                    history.append("Count of \(expression): \(results.text!)")
                case "average":
                    var total = 0.0
                    var historyString = ""
                    updateExpression()
                    for value in expression {
                        total = total + value
                        historyString.append(String(value) + " ")
                    }
                    results.text = String(total / Double(expression.count))
                    history.append("Average of \(historyString): \(results.text!)")
                default:
                    results.text = "Error!"
            }
            clearCalc()
        }
    }
}

