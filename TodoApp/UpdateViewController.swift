//
//  UpdateViewController.swift
//  TodoApp
//
//  Created by seyedamirhossein hashemi on 2017-06-08.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    var todoModel : TodoModel?
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var namefield: UITextField?
    
    @IBOutlet weak var detailField: UITextField?
    
    
    @IBOutlet weak var completedfield: UISwitch?
    
    @IBOutlet weak var idField: UITextField?
    
    @IBOutlet weak var noteField: UITextField?
    
    @IBOutlet weak var syncedField: UISwitch?

    override func viewDidLoad() {
        super.viewDidLoad()
         var idString = String(describing: todoModel?.todoId)
        
        
        infoLabel.text = "name: " + (todoModel?.name)! + "--id:" + idString +  "--notes :" + (todoModel?.notes)! + "--detail:" + (todoModel?.details)!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        
        guard let id = idField?.text,
            let name = namefield?.text
            
            else {
                let alertController = UIAlertController(title: "warning", message:
                    " Id and name are mandatory", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
        }
        
        guard  let desc = detailField?.text,
            let note = noteField?.text,
            let done = completedfield?.isOn,
            let sync = syncedField?.isOn
        
            
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
        
        
        TodoManager.updateTodo(headers as [String : AnyObject]){
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    print(response)
                }
            }
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
