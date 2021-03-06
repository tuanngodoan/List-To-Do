//
//  AllListViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 2/2/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AllListViewController: UITableViewController,ListDetailViewControllerDelegate{

    var dataModel:DataModel!
    //var fireBase:FireBaseModel!
    var fireBaseManager:FireBaseManager!
    var lists = [CheckList]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Load checkLists from User
        loadListFromSever()

        
        
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //let addItemButton = UIButton(type: .custom)
        //addItemButton.setImage(UIImage(named: "addItem.png"), for: .normal)
        //addItemButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //addItemButton.addTarget(self, action: #selector(AllListViewController.pushAddItemVC), for: .touchUpInside)
        // let item1 = UIBarButtonItem(customView: addItemButton)
        //self.navigationItem.setLeftBarButtonItems([item1], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fireBase = FireBaseModel()
        fireBaseManager = FireBaseManager()
        
        // Data from local
        //dataModel = DataModel()
    }
    
    func loadListFromSever(){
        
        var newLists = [CheckList]()
            fireBaseManager.rootRef.child(fireBaseManager.userUID).observe(.childAdded, with: { (snapshot) in
            
            //let value = snapshot.value as! NSDictionary
            
            let checklistItem = CheckList(snapshot: snapshot )
            newLists.append(checklistItem)
            self.lists = newLists

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func updateList(item: CheckList, index: Int){
        let key = fireBaseManager.rootRef.child(fireBaseManager.userUID).childByAutoId().key
        lists[index].keyID = key
        let listDic = item.parseToAnyObject()
        fireBaseManager.rootRef.child(fireBaseManager.userUID).child(key).setValue(listDic)
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        
        fireBaseManager.signOut { (isSignOut) in
            if isSignOut{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
            }else{
                
            }
        }
}
    
    
    // Add ItemCheckList
    //    func pushAddItemVC(){
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListDetailNavigationController")
    //
    //        self.present(vc!, animated: true, completion: nil)
    //    }

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
        
        let key = lists[indexPath.row].keyID
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        fireBaseManager.rootRef.child(fireBaseManager.userUID).child(key).removeValue()
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
        
        if newRow == 0 {
            for list in lists {
                updateList(item: list, index: newRow)
            }
        }else{
            updateList(item: checklist, index: newRow)
        }
        self.tableView.reloadData()
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEdittingItem checklist: CheckList) {
        
        if let index = lists.index(of: checklist){
            
            let indexPath = NSIndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath as IndexPath){
                cell.textLabel?.text = checklist.name
                // Update data to sever
                fireBaseManager.rootRef.child(fireBaseManager.userUID).child(lists[index].keyID).updateChildValues(["name":checklist.name])
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
