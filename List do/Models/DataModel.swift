//
//  saveData.swift
//  List do
//
//  Created by Doãn Tuấn on 3/9/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation

class DataModel: NSObject {
    
    var lists = [CheckList]()
    
    override init(){
        super.init()
        loadCheckListItem()
    }

    // Document
    func documentsDirectory() -> String{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        return paths[0]
    }
    
    func dataFilePath() -> String{
        print("\(documentsDirectory())/Checklists.plist")
        return "\(documentsDirectory())/Checklists.plist"
    }
    
    
    // Save data
    func saveChecklitsItem(){
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklist")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    // Load data
    func loadCheckListItem(){
        
        let path = dataFilePath()
        if FileManager.default.fileExists(atPath: path){
            if let data = NSData(contentsOfFile: path){
                
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
                
                lists = (unarchiver.decodeObject(forKey: "Checklist") as? [CheckList])!
                
                unarchiver.finishDecoding()
            }
        }
    }
}

