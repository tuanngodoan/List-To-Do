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
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
   
    required init?(coder aDecoder: NSCoder) {
       text =  aDecoder.decodeObject(forKey: "Text") as! String
        
       checked = aDecoder.decodeBool(forKey: "Checked")
        
       super.init()
    }
    
    override init(){
        super.init()
    }
    
}
