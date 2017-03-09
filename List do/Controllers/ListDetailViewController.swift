//
//  ListDetailViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 2/3/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    
    func listDetailViewControllerDidCancel(controller : ListDetailViewController)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem checklist: CheckList)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEdittingItem checklist: CheckList)
}


class ListDetailViewController : UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var donBarButton: UIBarButtonItem!
    
    weak var delegate : ListDetailViewControllerDelegate?
    
    var checklistToEdit:CheckList?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFiled.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit{
            title = "Edit Checklist"
            textFiled.text = checklist.name
            donBarButton.isEnabled = false
            
        }
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText:NSString = textField.text! as NSString
        let newText:NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        
        donBarButton.isEnabled = (newText.length > 0)
        return true
    }
    
    @IBAction func cancel(){
        delegate?.listDetailViewControllerDidCancel(controller: self)
    }
    
    @IBAction func done(){
        if let checklist = checklistToEdit{
            checklist.name = textFiled.text!
            delegate?.listDetailViewController(controller: self, didFinishEdittingItem : checklist)
        
        }else{
            
            let checklist = CheckList(name: textFiled.text!)
            checklist.name = textFiled.text!
            
            delegate?.listDetailViewController(controller: self, didFinishAddingItem: checklist)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
