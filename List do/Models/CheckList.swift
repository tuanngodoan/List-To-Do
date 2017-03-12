//
//  CheckList.swift
//  List do
//
//  Created by Doãn Tuấn on 2/2/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CheckList: NSObject/*, NSCoding*/ {
    
    var name = ""
    var done:Bool = false
    var shouldRemind = false
    var dueDate = Date(timeIntervalSinceNow: 0.0)
    var children = [CheckList]()
    
    func toggleChecked(){
        done = !done
    }
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "Name")
//        
//        aCoder.encode(done, forKey: "Done")
//        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
//        aCoder.encode(dueDate,forKey: "DueDate")
//        aCoder.encode(children,forKey: "Children")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        name =  aDecoder.decodeObject(forKey: "Name") as! String
//        done = aDecoder.decodeBool(forKey: "Done")
//        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
//        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
//        children = aDecoder.decodeObject(forKey: "Children") as! [CheckList]
//        super.init()
//    }
//    
    override init(){
        super.init()
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    // init for load Data from Sever
    init(snapshotValue: NSDictionary) {
        
        name = snapshotValue["name"] as! String
        done = snapshotValue["done"] as! Bool
        shouldRemind = snapshotValue["shouldRemind"] as! Bool
    }
    
    func parseToAnyObject() -> Any{
        return [
            "name": name,
            "done": done,
            "shouldRemind": shouldRemind,
            "dueDate": dueDate.dateToString(date: dueDate)
            //"Child": children
        ]
    }
    }
