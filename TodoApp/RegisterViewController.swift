//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by seyedamirhossein hashemi on 2017-06-22.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordR: UITextField!
    @IBOutlet weak var usernameR: UITextField!
    @IBAction func registerBtn(_ sender: UIButton) {
        
        let headers = [
            "content-type": "application/json",
            "username": usernameR.text as? String,
            "password": passwordR.text as? String,
            "cache-control": "no-cache",
            "postman-token": "b94a116a-4728-8490-c820-e799f20cb07a"
        ]
        
        
        
        LoginManager.addLogin(headers as [String : AnyObject]){
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    print(response)
                    
                }
            }
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
