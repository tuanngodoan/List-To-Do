//
//  LoginViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 3/9/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginButton(_ sender: Any) {
        if emailTextField.text! == "" || passwordTextField.text! == ""{
            let alertController = UIAlertController(title: "Error", message: "Enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                
                if error == nil {
                    print("successfully logged in")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckList")
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    print("error: \(error.debugDescription)")
                }
            })
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
