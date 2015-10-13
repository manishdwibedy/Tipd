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
    
    var tipPercentageSelected = -1.0
    
    // Bill amount changed.
    @IBAction func billAmountChanged(sender: AnyObject) {
        calculateTip()
    }
    
    // Tip percentage changed.
    @IBAction func tipPercentChanged(sender: AnyObject) {

        // Save the tip percentage irrespective of the error!
        var percentSelected = tipPercents[ sender.selectedSegmentIndex ]
        DB.insertData(sender.selectedSegmentIndex)
        
        tipPercentageSelected = Double(percentSelected)/100.0
        println(tipPercentageSelected)
        billAmount.resignFirstResponder()
        
        calculateTip()
    }
    
    // Calculates the tip
    func calculateTip()
    {
        // Bill amount is not entered
        if(billAmount.text == "")
        {
            var alert = UIAlertController(title: "Error!!", message: "Enter the bill amount", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            billAmount.becomeFirstResponder()
            return
        }
        
        // Tip percentage is not set
        if(tipPercentageSelected != -1.0)
        {
            var inputBillAmount = (billAmount.text as NSString).doubleValue ;
            
            var tipAmountCalculated = self.tipPercentageSelected * inputBillAmount
            tipAmount.text = tipAmountCalculated.description
            
            var totalAmountCalculated = inputBillAmount + tipAmountCalculated
            totalAmount.text = totalAmountCalculated.description
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
    
        // Initialize the DB
        DB.initDatabase()
    
        // Gets the last selected tip percentage
        let index = DB.getPreference("tipPercent")
        if( index != "")
        {
            tipPercent.selectedSegmentIndex = index.toInt()!
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

