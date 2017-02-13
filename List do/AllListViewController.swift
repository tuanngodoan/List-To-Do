//
//  AllListViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 2/2/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController,ListDetailViewControllerDelegate {

    var lists:[CheckList]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        lists = [CheckList]()
        
        super.init(coder: aDecoder)
        
        let list = CheckList(name: "Birthdays")
        lists.append(list)
        
        let list1 = CheckList(name: "Cool App")
        lists.append(list1)
        
        let list2 = CheckList(name: "To Do")
        lists.append(list2)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
        
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell{
        let cellIdentifier = "Cell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            return cell
        }else{
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellForTableView(tableView: tableView)
        
        let checklist = lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowCheckList", sender: checklist)
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
   

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let navigationController = storyboard?.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        
        controller.delegate = self
        
        let checklist = lists[indexPath.row]
        
        controller.checklistToEdit = checklist
        
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowCheckList"{
        
            let controller = segue.destination as! checkListViewController
            
            controller.checklist = sender as! CheckList
        }else{
            if segue.identifier == "AddChecklist"{
                
                let navigationCotroller = segue.destination as! UINavigationController
                
                let controller = navigationCotroller.topViewController as! ListDetailViewController
                
                controller.delegate = self
                controller.checklistToEdit = nil
                
                
            }
        }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem checklist: CheckList) {
        
        let newRow = lists.count
        
        lists.append(checklist)
        
        let indexPath = NSIndexPath(row: newRow, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEdittingItem checklist: CheckList) {
        
        if let index = lists.index(of: checklist){
            let indexPath = NSIndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath as IndexPath){
                cell.textLabel?.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}