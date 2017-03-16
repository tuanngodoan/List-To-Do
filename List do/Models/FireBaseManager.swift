//
//  LoginFireBase.swift
//  List do
//
//  Created by Doãn Tuấn on 3/10/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FireBaseManager: NSObject {
    
    var user:String = ""
    var password:String = ""
    var isRememerUser:Bool = false
    
    var Base_URL = "https://listdo-c8fa5.firebaseio.com"
    let rootRef:FIRDatabaseReference!
    let userUID:String!
    //var lists:[CheckList]!
    
    override init(){
        
        rootRef = FIRDatabase.database().reference()
        userUID = FIRAuth.auth()?.currentUser?.uid
        // lists = [CheckList]()
    }
    
    
    
    func signIn(userName:String, passWord: String, completion: @escaping (_ isSuccessfully: Bool) -> ()){
            FIRAuth.auth()?.signIn(withEmail: userName, password: passWord, completion: { (user, error) in
                if error == nil {
                    completion(true)
                }else{
                    completion(false)
                }
            })
        }
    
    
    func signOut(completion: (Bool)->()){
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                completion(true)
            } catch let error as NSError {
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    func registorAccount(){
        
    }
    
    
//    //
//    func writeNewListsDictionary(lists: [CheckList]){
//        
//        let index = lists.count
//        if index == 0 {
//            for list in lists {
//                updateList(listsItem: lists,listChild: : list, index: index)
//            }
//        }else{
//            updateList(listsItem: lists,list
//: lists[index-1], index: index)
//        }
//    }
    
//    func updateList(refString: String?, listsItem: [CheckList],item: CheckList, index: Int){
//       
//        let key = rootRef.child(refString!).childByAutoId().key
//        let listDic = item.parseToAnyObject()
//        listsItem[index].keyID = key
//        rootRef.child(refString!).setValue(listDic)
//    }
//    
//    //
    func remove() {
        
        
    }

}

