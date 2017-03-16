//
//  ViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 1/23/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
class checkListViewController: UITableViewController,ItemDetailViewControllerDelegate {
    
    var checklist:CheckList!
    var fireBaseManager:FireBaseManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        checklist = CheckList()
        fireBaseManager = FireBaseManager()
    }
    
    
    func writeNewItem(item: CheckList, index: Int){
        let key = fireBaseManager.rootRef.child(fireBaseManager.userUID).child("\(checklist.keyID)/childItems").childByAutoId().key
        checklist.childItems[index].keyID = key
        let listDic = item.parseChildItemsToAnyObject()
        fireBaseManager.rootRef.child(fireBaseManager.userUID).child("\(checklist.keyID)/childItems").child(key).setValue(listDic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.childItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistItem", for: indexPath)
        
        let item = checklist.childItems[indexPath.row]
        
        configureTextForCell(cell: cell, withChecklistItem: item)
        
        configueCheckmarkForCell(cell: cell, withChecklistItem: item )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = checklist.childItems[indexPath.row]
            item.toggleChecked()
            configueCheckmarkForCell(cell: cell, withChecklistItem: item)
            
            // update Done
            let key = checklist.childItems[indexPath.row].keyID
            fireBaseManager.rootRef.child(fireBaseManager.userUID).child("\(checklist.keyID)/childItems/\(key)/done").setValue(item.done)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let indexRow = indexPath.row
        let keyID = checklist.childItems[indexRow].keyID
        checklist.childItems.remove(at: indexRow)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)

        fireBaseManager.rootRef.child(fireBaseManager.userUID).child(checklist.keyID).child("childItems").child(keyID).removeValue()
    }
    
    func configueCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: CheckList){
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.done {
            label.text  = "✔"
        }else{
            label.text = " "
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: CheckList){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = ""
        label.text = item.name
    }
    
    // protocol delegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckList) {
        
        let newRow = checklist.childItems.count
        checklist.childItems.append(item)
        
        let indexPath = NSIndexPath(row: newRow, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
        
        print("Item = ", item.parseChildItemsToAnyObject())
        
        if newRow == 0{
            for child in checklist.childItems {
               writeNewItem(item: child, index: newRow)
            }
        }else{
            writeNewItem(item: item, index: newRow)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEdittingItem item: CheckList) {
       
        if let i =  checklist.childItems.index(of: item){
            let indexPath = NSIndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath as IndexPath){
                configureTextForCell(cell: cell, withChecklistItem: item)
                
                let key = fireBaseManager.rootRef.child(fireBaseManager.userUID).child("\(checklist.keyID)/childItems/\(item.keyID)")
                let listDic = item.parseChildItemsToAnyObject()
                key.setValue(listDic)
            }
        }
        
        dismiss(animated: true, completion: nil)
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
                    controller.itemToEdit = checklist.childItems[indexPath.row]
                }
        }
    }
 }
}

