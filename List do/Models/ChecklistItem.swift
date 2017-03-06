//
//  ChecklistItem.swift
//  List do
//
//  Created by Doãn Tuấn on 1/29/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit


class ChecklistItem: NSObject, NSCoding{

    var text = ""
    var checked:Bool = false
    var shouldRemind = false
    //var itemID:Int
    var dueDate:Date = Date()
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        //aCoder.encode(itemID, forKey: "itemID")
        //aCoder.encode(dueDate,forKey: "DueDate")
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        text =  aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        //dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        //itemID = aDecoder.decodeInteger(forKey: "itemID")
       super.init()
    }
    
    override init(){
        
        super.init()
    }
    
}
