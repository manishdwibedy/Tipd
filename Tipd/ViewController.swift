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
        
        if(billAmount.text == "")
        {
            var alert = UIAlertController(title: "Error!!", message: "Enter the bill amount", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            billAmount.becomeFirstResponder()
            return
        }
        billAmount.resignFirstResponder()
        var percentSelected = tipPercents[ sender.selectedSegmentIndex ]
        var inputBillAmount = (billAmount.text as NSString).floatValue ;
        
        var tipAmountCalculated = Float(percentSelected) * inputBillAmount / 100
        tipAmount.text = tipAmountCalculated.description
        
        var totalAmountCalculated = inputBillAmount + tipAmountCalculated
        totalAmount.text = totalAmountCalculated.description
    
        insertData(percentSelected)
    }
    
    func loadDatabase(){
        var d = DB()
        if !d.getFileManager().fileExistsAtPath(d.getDBPath() as String) {
            
            let contactDB = FMDatabase(path: d.getDBPath() as String)
            
            if contactDB == nil {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
                println("Database connection..")
            } else {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
    }
    
    func insertData(tipPercent : Int)
    {
        var d =  DB()
        
        let contactDB = FMDatabase(path: d.getDBPath() as String)
        
        if contactDB.open() {
            
            let insertSQL = "INSERT INTO CONTACTS (name, address, phone) VALUES ('\(tipPercent.description)', 'dummy', 'dummy')"
            
            let result = contactDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(contactDB.lastErrorMessage())")
            } else {
            }
        } else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
        
        loadDatabase()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

