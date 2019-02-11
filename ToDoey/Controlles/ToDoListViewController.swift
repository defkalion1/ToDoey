//
//  ViewController.swift
//  ToDoey
//
//  Created by Defkalion on 03/12/2018.
//  Copyright © 2018 Constantine Defkalion. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // loadItems()
    
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title!
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
        
    }
    
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        //loadItems()
        
        
        //This is for the selection not to be highlighted when we select it
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
      
    }
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when the user presses the add button
            
            let newItem = Item(context: self.context)
            newItem.title = textFeild.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            //self.loadItems()
            
            }
        alert.addTextField { (alertTextFeild) in
            textFeild = alertTextFeild
            alertTextFeild.placeholder = "Create New Item"
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    
    }
    
    func saveItems() {
        
        do{
        try context.save()
            
        } catch {
           print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do{
//            itemArray = try decoder.decode([Item].self, from: data)
//            }catch {
//                print(error)
//            }
//        }
//    }
    
}

