//
//  HistoryViewController.swift
//  simple-calc-ios
//
//  Created by Jimmy Nguyen on 10/30/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var history = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for value in history {
            let label = UILabel(frame: CGRect(x: 0, y: 25 + history.index(of: value)! * 40, width: 500, height: 100))
            label.textColor = UIColor.white
            label.text = value
            self.view.addSubview(label)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calculatorView = segue.destination as! ViewController
        calculatorView.history = self.history
    }
}
