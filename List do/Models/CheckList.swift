//
//  CheckList.swift
//  List do
//
//  Created by Doãn Tuấn on 2/2/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class CheckList: NSObject, NSCoding {
    
    var name = ""
    var id  = ""
    var done:Bool = false
    var shouldRemind = false
    var dueDate = Date(timeIntervalSinceNow: 0.0)
    var children = [CheckList]()
    func toggleChecked(){
        done = !done
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(id,forKey:"Id")
        aCoder.encode(done, forKey: "Done")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(dueDate,forKey: "DueDate")
        aCoder.encode(children,forKey: "Children")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name =  aDecoder.decodeObject(forKey: "Name") as! String
        id = aDecoder.decodeObject(forKey: "Id") as! String
        done = aDecoder.decodeBool(forKey: "Done")
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        children = aDecoder.decodeObject(forKey: "Children") as! [CheckList]
        super.init()
    }
    
    override init(){
        super.init()
    }
    init(name: String) {
        self.name = name
        super.init()
    }
}
