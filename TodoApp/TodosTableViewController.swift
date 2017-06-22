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
    var indexOfRow : Int?
//    var firstLaunch : Bool?
    
    var rowHere : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firstLaunch = true
        
   
        // read the data from database
       
//        readDataFromDatabase(){
//            (responseToSend) in
//            if let response = responseToSend {
//                self.addDataBaseToServer(response)
//            }
//            
//        }
        

        
        
        
//        firstLaunch = false
        getDataFromServer()
        
    }
    
    override func viewWillAppear(_ : Bool) {
        
            getDataFromServer()
        
        
    }
    
//    func readDataFromDatabase(_ datatoServer : @escaping (_ responseToSend : [TodoModel]?) ->Void){
//                TodoManager.localTodos{
//                    (responseData, error) in
//                    if error == false {
//                        if let response = responseData{
//                            self.todos = response
//                            print("this is the todo response \(self.todos)")
////                            print("this is my \(response)")
//                            datatoServer(response)
//                            self.tableView.reloadData()
//        
//                        }
//                        
//                    }
//            }
//    }
    
    // get the data from server and reload table view
    func getDataFromServer(){
        TodoManager.todos {
            (responseData, error) in
            print("stage 4")
            if error == false {
                if let response = responseData{
                    self.todos = response
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
    
    }
//    func addDataBaseToServer(_ arrayOfTodos : [TodoModel]){
//        var listOfAdds = [[String : AnyObject]]()
//        for todo in arrayOfTodos {
//
//            let header = [
//                
//                "id": String(todo.todoId),
//                "name": todo.name,
//                "description": todo.description,
//                "synced": String(todo.synced),
//                "completed": String(todo.completed),
//                "notes": todo.notes,
//                "duedate": todo.dueDate,
//                "startingDate": todo.startingDate,
//                
//                ] as [String : AnyObject]
//            listOfAdds.append(header)
//        }
//        let headers = ["allTodo" : listOfAdds]
//        
//                TodoManager.addAllTodo(headers as? [String : AnyObject]){
//                (responseData, error) in
//                if error == false {
//                    if let response = responseData{
//                        print(response)
//                       
////                        print("this is sssssss \(dueDate)")
//                    }
//                }
//            }
//            
//        
//    }
    
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MyTableViewCellControllerTableViewCell
        let currentTime = Date()
        let endTime = dateFromString(todos[indexPath.row].dueDate)
        let startTime = dateFromString(todos[indexPath.row].startingDate)
        let differenceBetweenCurrentAndStart = currentTime.timeIntervalSince(startTime!)
        
        let differenceBetweenDueDateAndStart = endTime?.timeIntervalSince(startTime!)
    
        let percentageDate =   differenceBetweenCurrentAndStart / differenceBetweenDueDateAndStart!
        print("ff \(percentageDate)")
        cell.taskNameLabel.text = todos[indexPath.row].name
        cell.timeProgressBar.progress = Float(percentageDate)
        if percentageDate < 0.35 {
            cell.backgroundColor = UIColor.blue
        } else if percentageDate < 0.70 {
            cell.backgroundColor = UIColor.orange
        } else {
            cell.backgroundColor = UIColor.red
        }
       
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            rowHere = indexPath.row
            let dictionaryObject = [
                "content-type": "application/json",
                "id": String(self.todos[self.rowHere!].todoId),
                "name": self.todos[self.rowHere!].name,
                "description": self.todos[self.rowHere!].description,
                "synced": String(self.todos[self.rowHere!].synced),
                "completed": String(self.todos[self.rowHere!].completed),
                "notes": self.todos[self.rowHere!].notes,
                ] as [String : Any]
            
            TodoManager.deleteTodo(dictionaryObject as [String : AnyObject],
                                   { (responseData, error) in
                                    if error == false {
                                        if let response = responseData {
                                            print("this is a dlete \(response)")
                                        }
                                    }
            })
//            deleteFromDatabase(self.todos[self.rowHere!])
            
            
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfRow = indexPath[1]
        
        //currentLines.removeAll() }
        performSegue(withIdentifier: "tableToDetail", sender: self)
        
        print(indexPath.row)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableToDetail" {
            let vc = segue.destination as! UpdateViewController
            vc.todoModel = self.todos[self.indexOfRow!]
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
    
    func dateFromString(_ dateAsString: String?) -> Date? {
        guard let string = dateAsString else { return nil }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.date(from: string)
        return val
    }
    
}
