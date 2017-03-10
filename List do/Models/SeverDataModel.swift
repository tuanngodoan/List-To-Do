//
//  SeverDataModel.swift
//  List do
//
//  Created by Doãn Tuấn on 3/10/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import FirebaseDatabase

class SeverDataModel {
   
    var dataLocal:DataModel!
    
    func writeDataSever(){
        
        dataLocal = DataModel()
        
        let lists = dataLocal.lists
        
        let rootRef = FIRDatabase.database().reference(fromURL: "https://listdo-c8fa5.firebaseio.com")
        
        for list in lists{
            
        rootRef.child("Lists").setValue(list.parseToAnyObject())
        
        }
    }
    

    
}
