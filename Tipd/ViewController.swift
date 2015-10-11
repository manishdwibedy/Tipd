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

        var percentSelected = tipPercents[ sender.selectedSegmentIndex ]
        
        // Save the tip percentage irrespective of the error!
        DB.insertData(sender.selectedSegmentIndex)
        if(billAmount.text == "")
        {
            var alert = UIAlertController(title: "Error!!", message: "Enter the bill amount", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            billAmount.becomeFirstResponder()
            return
        }
        billAmount.resignFirstResponder()
        
        var inputBillAmount = (billAmount.text as NSString).floatValue ;
        
        var tipAmountCalculated = Float(percentSelected) * inputBillAmount / 100
        tipAmount.text = tipAmountCalculated.description
        
        var totalAmountCalculated = inputBillAmount + tipAmountCalculated
        totalAmount.text = totalAmountCalculated.description
    

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
    
        // Initialize the DB
        DB.initDatabase()
        println("percentage")
        println(DB.getPreference("tipPercent"))
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

