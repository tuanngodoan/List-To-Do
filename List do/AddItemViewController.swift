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
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEdittingItem item: ChecklistItem)
}


class ItemDetailViewController : UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var donBarButton: UIBarButtonItem!
    
    weak var delegate : ItemDetailViewControllerDelegate?
    
    var itemToEdit:ChecklistItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFiled.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donBarButton.isEnabled = false
        
        if let item = itemToEdit{
           title = "Edit Item"
           textFiled.text = item.text
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
            item.text = textFiled.text!
            delegate?.itemDetailViewController(controller: self, didFinishEdittingItem : item)
        }else{
            
            let item:ChecklistItem = ChecklistItem()
            item.text = textFiled.text!
            item.checked = false
            
            delegate?.itemDetailViewController(controller: self, didFinishAddingItem: item)
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
