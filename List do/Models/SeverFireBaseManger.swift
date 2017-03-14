//
//  SeverDataModel.swift
//  List do
//
//  Created by Doãn Tuấn on 3/10/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

//typealias completionLoadDataClosure

class SeverDataModel {
   
    static let sharedInstance = SeverDataModel()
    
    var Base_URL = "https://listdo-c8fa5.firebaseio.com"
    let rootRef:FIRDatabaseReference!
    let userUID:String!
    //var lists:[CheckList]!
    init(){
        
        rootRef = FIRDatabase.database().reference()
        userUID = FIRAuth.auth()?.currentUser?.uid
       // lists = [CheckList]()
    }
    


//    func updateValue(){
//        self.rootRef.child(userUID).queryOrderedByKey().
//        
//        self.rootRef.child(userUID/\())
//    }
    
    
//    func writeDataToSever(){
//        
//    }
//    
//    func loadDataFromSever(){
//        let list = CheckList()
//                self.rootRef.child(self.userUID).observe(.childAdded, with: { (snapshot) in
//                let value = snapshot.value as! NSDictionary
//                print("Value = ", value)
//                self.lists.append(list)
//            })
//    }
    
    
}
