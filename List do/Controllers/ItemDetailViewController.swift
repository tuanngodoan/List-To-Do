//
//  ItemDetailViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 1/29/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    
    func itemDetailViewControllerDidCancel(controller : ItemDetailViewController)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckList)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEdittingItem item: CheckList)
}


class ItemDetailViewController : UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var donBarButton: UIBarButtonItem!
    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dueDateTitle: UILabel!
    
    
    var dueDate:Date = Date()
    var check:Bool = false
    
    weak var delegate : ItemDetailViewControllerDelegate?
    
    var itemToEdit:CheckList!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFiled.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donBarButton.isEnabled = false
        
        
        if let item = itemToEdit{
           title = "Edit Item"
           textFiled.text = item.name
           remindSwitch.isOn  = item.shouldRemind
           dueDate = item.dueDate as Date
        }
        remindSwitch.isOn = false
        datePicker.isHidden = true
        dueDateTitle.isEnabled = false
        updateDueDateLabel()
    }
    
    
    func updateDueDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dueDateTitle.text = formatter.string(from: dueDate)
    }
    
    @IBAction func remindSwitchChanged(sender: UISwitch){
        donBarButton.isEnabled = true
        if remindSwitch.isOn == true {
            datePicker.isHidden = false
        }else{
            datePicker.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText:NSString = textFiled.text! as NSString
        
        let newText:NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        
        
        donBarButton.isEnabled = (newText.length > 0)
 
        return true
    }
    
    
    
    @IBAction func cancel(){
        delegate?.itemDetailViewControllerDidCancel(controller: self)
    }
    
    @IBAction func done(){
        if let item = itemToEdit{
            item.name = textFiled.text!
            item.shouldRemind = remindSwitch.isOn
            item.dueDate = dueDate
            delegate?.itemDetailViewController(controller: self, didFinishEdittingItem : item)
        }else{
            
            let item:CheckList = CheckList()
            item.name = textFiled.text!
            item.done = false
            item.shouldRemind = remindSwitch.isOn
            item.dueDate = dueDate
            delegate?.itemDetailViewController(controller: self, didFinishAddingItem: item)
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    // insert date picker
    
    @IBAction func dateChanged(datePicker: UIDatePicker){
        dueDate = datePicker.date
        updateDueDateLabel()
        
        let selectedDate = datePicker.date
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let title:String = textFiled.text!
        delegate?.scheduleNotification(at: selectedDate, title: title, remindContent: title)
    }

}

