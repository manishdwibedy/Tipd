//
//  DB.swift
//  Tipd
//
//  Created by Student on 10/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

public class DB{
    var databasepath : String
    var filemgr : NSFileManager
    init(){
        filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        
        self.databasepath = docsDir.stringByAppendingPathComponent("contacts.db")

    }
    
    func getDBPath() -> String{
        return databasepath
    }
    
    func getFileManager() -> NSFileManager{
        return filemgr
    }
}