//
//  TodoDetailViewController.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var detailField: UITextField?
    @IBOutlet weak var doneSwitch: UISwitch?
    
    @IBOutlet weak var idField: UITextField?
    
    @IBOutlet weak var noteField: UITextField?
    
    @IBOutlet weak var synckedField: UISwitch?
    
    @IBAction func doneBtn(_ sender: UIButton) {

        
        
        guard let id = idField?.text,
            let name = nameField?.text
   
            else {
                let alertController = UIAlertController(title: "warning", message:
                    " Id and name are mandatory", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
        }
        
        guard  let desc = detailField?.text,
            let note = noteField?.text,
            let done = doneSwitch?.isOn,
            let sync = synckedField?.isOn
            
            
            else {
                
                return
        }
        
                let headers = [
                    "content-type": "application/json",
                    "id": id,
                    "name": name,
                    "description": desc,
                    "synced": String(sync),
                    "completed": String(done),
                    "notes": note,
                    "cache-control": "no-cache",
                    "postman-token": "f84b8c06-9833-29e1-3cee-c9efe8829792"
                ]

        
        TodoManager.addTodo(headers as [String : AnyObject]){
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    print(response)
                }
            }
        }
        
        if id.isEmpty && name.isEmpty {
            let alertController = UIAlertController(title: "warning", message:
                " Id and name are mandatory", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else {
            let alertController = UIAlertController(title: "warning", message:
                " successfuly added", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
