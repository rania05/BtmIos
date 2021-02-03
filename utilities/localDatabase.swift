//
//  localDatabase.swift
//  BTMFINAL
//
//  Created by macbook on 12/28/20.
//

import Foundation
import SQLite3

class localDB {
   
    var db : OpaquePointer?
    var path : String = "myDb.sqlite"
    init() {
        self.db = createDB()
        self.createTable(request: "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY,email TEXT,password TEXT);")
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for : .documentDirectory, in : .userDomainMask,appropriateFor: nil,create: false).appendingPathExtension(path)
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("error")
            return nil
        }else {
            print("YALA")
            return db
        }
    }
    
    func createTable (request : String ){
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db,request,-1,&createTable,nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table creation success")
            } else {
                print("Table creation failed")
            }
            
        }else {
            print("Preparation failed")
        }
    }
    
    func insertUser (id : Int,email : String,password : String) {
        
        let insertStatementString = "INSERT INTO user (id, email, password) VALUES (?, ?, ?);"
               var insertStatement: OpaquePointer? = nil
               if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                   sqlite3_bind_int(insertStatement, 1, Int32(id))
                   sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
                   
                   if sqlite3_step(insertStatement) == SQLITE_DONE {
                       print("Successfully inserted row.")
                  
                   } else {
                       print("Could not insert row.")
                   }
               } else {
                   print("INSERT statement could not be prepared.")
               }
               sqlite3_finalize(insertStatement)
    }
    
    func read() -> [User] {
            let queryStatementString = "SELECT * FROM user;"
            var queryStatement: OpaquePointer? = nil
            var psns : [User] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    psns.append(User(id: Int(id), email: email, password: password))
                    print("Query Result:")
                    print("\(id) | \(email) | \(password)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return psns
        }
}
