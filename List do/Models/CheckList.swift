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
    
    var severData = FireBaseManager()
    
    func toggleChecked(){
        done = !done
    }

    override init(){
        super.init()
        for child in childItems {
            child.keyID = severData.rootRef.childByAutoId().key
        }
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
            if let Items = snapshotValue["childItems"] as! NSDictionary!{
                
                
                for (key,_) in Items {
                    let childItem = CheckList()
                    childItem.keyID = key as! String
                    if let itemDic = Items[key] as? NSDictionary! {
                        if let name = itemDic["name"] as! String!{
                            childItem.name = name
                        }
                        if let done = itemDic["done"] as! Bool!{
                            childItem.done = done
                        }
                        if let shouldRemind = itemDic["shouldRemind"] as! Bool!{
                            childItem.shouldRemind = shouldRemind
                        }
                        if let dueDate = itemDic["dueDate"] as! String! {
                            var date = Date()
                            date = date.stringToDate(dateString: dueDate)
                            childItem.dueDate = date
                        }
                    }
                    childItems.append(childItem)
                }
                }
            }
    }
    
    //
    func parseToAnyObject() -> [String:Any]{
        var Items = [String:NSDictionary]()
        
        for item in childItems{
                Items[item.keyID] = item.parseChildItemsToAnyObject()
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
