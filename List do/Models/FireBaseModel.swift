//
//  LoginFireBase.swift
//  List do
//
//  Created by Doãn Tuấn on 3/10/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import FirebaseAuth

class FireBaseModel: NSObject /*,NSCoding*/ {
    
    var user:String = ""
    var password:String = ""
    var isRememerUser:Bool = false
    
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
}

    
    
//    // Document
//    func documentsDirectory() -> String{
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        
//        return paths[0]
//    }
//    
//    func dataFilePath() -> String{
//        print("\(documentsDirectory())/Checklists.plist")
//        return "\(documentsDirectory())/Checklists.plist"
//    }
//    
//    
//    // Save data
//    func saveChecklitsItem(){
//        
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(lists, forKey: "Checklist")
//        archiver.finishEncoding()
//        data.write(toFile: dataFilePath(), atomically: true)
//    }
//    
//    // Load data
//    func loadCheckListItem(){
//        
//        let path = dataFilePath()
//        if FileManager.default.fileExists(atPath: path){
//            if let data = NSData(contentsOfFile: path){
//                
//                let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
//                
//                lists = (unarchiver.decodeObject(forKey: "Checklist") as? [CheckList])!
//                
//                unarchiver.finishDecoding()
//            }
//        }
//    }
