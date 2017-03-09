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
    
    var checklist:CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistItem", for: indexPath)
        
        let item = checklist.children[indexPath.row]
        
        configureTextForCell(cell: cell, withChecklistItem: item)
        
        configueCheckmarkForCell(cell: cell, withChecklistItem: item )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = checklist.children[indexPath.row]
            item.toggleChecked()
            configueCheckmarkForCell(cell: cell, withChecklistItem: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checklist.children.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)

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
        label.text = item.name
    }
    
    // protocol delegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckList) {
        
        let newRow = checklist.children.count
        checklist.children.append(item)
        
        let indexPath = NSIndexPath(row: newRow, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)

        dismiss(animated: true, completion: nil)

    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEdittingItem item: CheckList) {
       
        if let i =  checklist.children.index(of: item){
            let indexPath = NSIndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath as IndexPath){
                configureTextForCell(cell: cell, withChecklistItem: item)
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
                    controller.itemToEdit = checklist.children[indexPath.row]
                }
        }
    }
 }
}

