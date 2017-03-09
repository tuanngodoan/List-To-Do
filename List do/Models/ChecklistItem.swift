//
//  ChecklistItem.swift
//  List do
//
//  Created by Doãn Tuấn on 1/29/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit


class ChecklistItem: NSObject, NSCoding{

    var name = ""
    var id  = ""
    var done:Bool = false
    var shouldRemind = false
    var dueDate = Date(timeIntervalSinceNow: 0.0)
    
    func toggleChecked(){
        done = !done
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(id,forKey:"Id")
        aCoder.encode(done, forKey: "Done")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(dueDate,forKey: "DueDate")
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        name =  aDecoder.decodeObject(forKey: "Name") as! String
        id = aDecoder.decodeObject(forKey: "Id") as! String
        done = aDecoder.decodeBool(forKey: "Done")
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
       super.init()
    }
    
    override init(){
        
        super.init()
    }
    
}
