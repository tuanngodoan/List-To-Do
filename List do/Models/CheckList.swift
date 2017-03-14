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
    
    var name:String = ""
    var done:Bool = false
    var shouldRemind = false
    var dueDate = Date(timeIntervalSinceNow: 0.0)
    var keyID = ""
    var childItems = [CheckList]()
    
    func toggleChecked(){
        done = !done
    }

    override init(){
        super.init()
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    // init for load Data from Sever
    init(snapshot: FIRDataSnapshot) {
        
        self.keyID  = snapshot.key
        
        if let snapshotValue = snapshot.value as! NSDictionary!{
           
            if let name  = snapshotValue["name"] as! String!{
                self.name = name
            }
            if let Items = snapshotValue["childItems"] as! Array<NSDictionary>!{
                for item in Items{
                    let childItem = CheckList()
                    childItem.name = item["name"] as! String
                    childItem.done = item["done"] as! Bool
                    childItem.shouldRemind = item["shouldRemind"] as! Bool
                    //childItem.dueDate = item["dueDate"] as! Date
                    childItems.append(childItem)
                }
                
            }
        }
        
   
}
    
    func parseToAnyObject() -> [String:Any]{
        var  i = 0
        var Items = [Int:NSDictionary]()
        
        for item in childItems{
                Items[i] = item.parseChildItemsToAnyObject()
            i = i + 1
        }
        return [
            "name": name,
            "childItems": Items
        ]
    }
    //
    func parseChildItemsToAnyObject() -> NSDictionary{
        return [
            "name": name,
            "done": done,
            "shouldRemind": shouldRemind,
            "dueDate": dueDate.dateToString(date: dueDate)
        ]
    }
}
