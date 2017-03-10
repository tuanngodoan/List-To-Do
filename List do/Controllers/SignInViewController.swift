//
//  LoginViewController.swift
//  List do
//
//  Created by Doãn Tuấn on 3/9/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var fireBase:FireBaseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireBase = FireBaseModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func signInButton(_ sender: Any) {
        loginWithFireBase(userName: emailTextField.text!, password: passwordTextField.text!)
    }
    

    // Login with account FireBase
    func loginWithFireBase(userName:String,password:String){
        if userName == "" || password == ""{
            self.alertToUser(title: "Error", messenge: "Enter email and password, Please!")
        }else{
            fireBase.signIn(userName: userName, passWord: password, completion: { (isSuccessfullyLogin) in

                if isSuccessfullyLogin {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckList")
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    self.alertToUser(title: "Failed to log in", messenge: "Email and password is incorrect")
                }
            })
        }
    }

    
    // alertToUSer
    func alertToUser(title:String, messenge: String){
        let alertController = UIAlertController(title: title, message: messenge, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion:nil)
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
