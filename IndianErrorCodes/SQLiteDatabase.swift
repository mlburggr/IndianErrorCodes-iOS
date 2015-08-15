//
//  SQLiteDatabase.swift
//  IndianErrorCodes
//
//  Created by Maxwell Burggraf on 7/27/15.
//  Copyright (c) 2015 Maxwell Burggraf. All rights reserved.
//

import Foundation
import SQLite
import UIKit

class SQLiteDatabase {
    
    static var table: SQLite.Query!
    
    class func getTable() -> SQLite.Query {
        return table
    }
    
    class func setupDb() {
        
        
    
    let theFileManager = NSFileManager.defaultManager()
    
    let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true
        ).first as! String
    
    
    if theFileManager.fileExistsAtPath(documentDirectoryPath.stringByAppendingPathComponent("/ErrorCodes.db")) {
    println("File Found!")
    // And then open the DB File
    } else {
    let pathToBundledDB = NSBundle.mainBundle().pathForResource("ErrorCodes", ofType: "db")!
    
    
    println("Path to bundled DB: \(pathToBundledDB)")
    
    var error:NSError? = nil
    
    if (theFileManager.copyItemAtPath(pathToBundledDB, toPath:documentDirectoryPath.stringByAppendingPathComponent("/ErrorCodes.db"), error: &error)) {
    // success
    println("success")
    }
    else {
    // failure
    println("error: \(error)")
    
    println("\ncouldnt copy \n \(pathToBundledDB) \n to \n \(documentDirectoryPath)")
    }
    }
    
    let dbPath = documentDirectoryPath.stringByAppendingPathComponent("/ErrorCodes.db")
    let db = Database("\(documentDirectoryPath)/ErrorCodes.db")
    let indianErrorCodes = db["IndianErrorCodes2014"]
    let spn = Expression<String>("SPN")
    let fmi = Expression<String>("FMI")
        
    table = indianErrorCodes
    
    println("\(indianErrorCodes.dynamicType)")
    
    }

    
}