//
//  ViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 1/23/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import Foundation

class checkListViewController: UITableViewController,ItemDetailViewControllerDelegate {
    
    var items = [ChecklistItem]()
    var checklist:CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadCheckListItem()
    }
    
    // Document

    func documentsDirectory() -> String{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        return paths[0]
    }

    func dataFilePath() -> String{
                return "\(documentsDirectory())/Checklists.plist"
    }
    
    ///
    
    // Save data
    func saveChecklitsItem(){
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
        
    }
    
    // Load data
    
    func loadCheckListItem(){
        
        let path = dataFilePath()
        
        if FileManager.default.fileExists(atPath: path){
            if let data = NSData(contentsOfFile: path){
                
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
                
                items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
                
                unarchiver.finishDecoding()
            }
        }
    }
    
    ///

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureTextForCell(cell: cell, withChecklistItem: item)
        
        configueCheckmarkForCell(cell: cell, withChecklistItem: item )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = items[indexPath.row]
            item.toggleChecked()
            configueCheckmarkForCell(cell: cell, withChecklistItem: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklitsItem()
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklitsItem()
    }
    
    func configueCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem){
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text  = "✔️"
        }else{
            label.text = " "
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    // protocol delegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        
        let newRow = items.count
        items.append(item)
        
        let indexPath = NSIndexPath(row: newRow, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)

        dismiss(animated: true, completion: nil)
        
        saveChecklitsItem()
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEdittingItem item: ChecklistItem) {
       
        if let i =  items.index(of: item){
            let indexPath = NSIndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath as IndexPath){
                configureTextForCell(cell: cell, withChecklistItem: item)
            }
        }
            dismiss(animated: true, completion: nil)
        saveChecklitsItem()
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //1
        if segue.identifier == "AddItem"{
            //2
            let navigationController = segue.destination as! UINavigationController
            //3
            let controller = navigationController.topViewController as! ItemDetailViewController
            //4
            controller.delegate = self
        }else{
            if segue.identifier == "EditItem"{
                
                let navigationController  = segue.destination as! UINavigationController
                
                let controller = navigationController.topViewController as! ItemDetailViewController
                
                controller.delegate = self
                
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.itemToEdit = items[indexPath.row]
                }
        }
    }
 }
}

