//
//  DB.swift
//  Tipd
//
//  Created by Student on 10/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

public class DB{
    public let databasepath : String
    let filemgr : NSFileManager
    init(){
        filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        
        databasepath = docsDir.stringByAppendingPathComponent("tips.db")

    }
    
    class func initDatabase() -> Bool{
        var d = DB()
        if !d.getFileManager().fileExistsAtPath(d.getDBPath() as String) {
            
            let contactDB = FMDatabase(path: d.getDBPath() as String)
            
            if contactDB == nil {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS PREFS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, VALUE TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    println("Could not execute statement: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
                return true
            } else {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
        return false
    }
    
    class func insertData(tipPercent : Int)
    {
        var d =  DB()
        
        let contactDB = FMDatabase(path: d.getDBPath() as String)
        
        if contactDB.open() {
            
            let insertSQL = "INSERT INTO PREFS (NAME, VALUE) VALUES ('tipPercent','\(tipPercent.description)')"
            
            println("Inserting tip percentage as \(tipPercent)")
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
    
    class func getPreference(name: String) -> String{
        var d = DB()
        var value = ""
        let contactDB = FMDatabase(path: d.getDBPath() as String)
        
        if contactDB.open() {
            let querySQL = "SELECT VALUE FROM PREFS WHERE NAME = '\(name)'"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            if results?.next() == true {
                value = results!.stringForColumn("VALUE")!
            }
            contactDB.close()
        } else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
        return value
    }
    
    func getDBPath() -> String{
        return databasepath
    }
    
    func getFileManager() -> NSFileManager{
        return filemgr
    }
}