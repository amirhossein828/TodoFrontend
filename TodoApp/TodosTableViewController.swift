//
//  TodosTableViewController.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import UIKit
import RealmSwift

class TodosTableViewController: UITableViewController {
    
    var todos = [TodoModel]()
    
 
    var rowHere : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // read the data from database
        TodoManager.localTodos{
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    self.todos = response
        
                    self.tableView.reloadData()
                    
                }
            }
    }
      
    }
    
        
        
    override func viewWillAppear(_ animated: Bool) {
        // get the data drom server and save it locally
        TodoManager.todos {
            (responseData, error) in
            if error == false {
                if let response = responseData{

                }
            }
        }
        
        // read from database  
        TodoManager.localTodos{
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    self.todos = response
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = todos[indexPath.row].name
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            rowHere = indexPath.row
            // it crashes the app when I want to delete from database
            
            delete(self.todos[self.rowHere!])
            
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            
            
            
        }
    }
    
//     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            self.todos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
//        }
//    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    

    
   
 
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
