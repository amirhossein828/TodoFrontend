//
//  LoginViewController.swift
//  TodoApp
//
//  Created by seyedamirhossein hashemi on 2017-06-16.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController  ,DelegateName {
    
    var e  : RegisterViewController?
    
    var s : String?

    @IBOutlet weak var txtFieldUserName: UITextField!
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBAction func btnLogIn(_ sender: UIButton) {
        LoginManager.logIn(userName: txtFieldUserName.text!, password: txtFieldPassword.text!) {
            (responseData, error) in
            if let response = responseData {
                if response.success == true {
                    print(response)
                    let todosViewController = self.storyboard?.instantiateViewController(withIdentifier: "TodosTableViewController")
                    self.navigationController?.pushViewController(todosViewController!, animated: true)
                } else {
                    print("User name and password were not correct")
                    let alert = UIAlertController(title: "Error", message: "User name and password were not correct", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            } else if  error == true {
                print("Backend error")
                let alert = UIAlertController(title: "Error", message: "Something went wrong with the backend", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

    
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
//    e = RegisterViewController()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savedData(name: String) {
        txtFieldUserName.text = name
        print("fdf")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "regToLog" {
            let vc = segue.destination as! RegisterViewController
            vc.delegate = self
            
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
   


}
