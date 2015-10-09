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
    func loadDatabase(){
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        
        let databasePath = docsDir.stringByAppendingPathComponent(
            "contacts.db")
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            } else {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
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

