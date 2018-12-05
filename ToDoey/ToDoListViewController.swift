//
//  ViewController.swift
//  ToDoey
//
//  Created by Defkalion on 03/12/2018.
//  Copyright © 2018 Constantine Defkalion. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["1","2"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //This is for the selection not to be highlighted when we select it
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when the user presses the add button
            
            self.itemArray.append(textFeild.text!)
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
            
            }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New Item"
            textFeild = alertTextFeild
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
}

