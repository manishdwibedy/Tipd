//
//  ViewController.swift
//  Tipd
//
//  Created by Student on 10/9/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tipPercents = [5,10,15,20,25]
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UITextField!
    @IBOutlet weak var totalAmount: UITextField!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    
    
    @IBAction func tipPercentChanged(sender: AnyObject) {
        billAmount.resignFirstResponder()
        var percentSelected = tipPercents[ sender.selectedSegmentIndex ]
        var inputBillAmount = (billAmount.text as NSString).floatValue ;
        
        var tipAmountCalculated = Float(percentSelected) * inputBillAmount / 100
        tipAmount.text = tipAmountCalculated.description
        
        var totalAmountCalculated = inputBillAmount + tipAmountCalculated
        totalAmount.text = totalAmountCalculated.description
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

