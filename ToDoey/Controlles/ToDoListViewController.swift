//
//  ViewController.swift
//  ToDoey
//
//  Created by Defkalion on 03/12/2018.
//  Copyright © 2018 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ToDoListViewController: SwipeTableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = 80.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let categoryName = selectedCategory?.name {
        title = categoryName
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
         cell.textLabel?.text = todoItems?[indexPath.row].title ?? "No Items Have Been Added Yet"
        
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
        
    }
    
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
            }
            } catch {
                print("Error saving done status\(error)")
            }
        }
        
        tableView.reloadData()

        
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
         
            if let currentCategory = self.selectedCategory {
                
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textFeild.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    
                }
                }catch {
                    print("Error saving items\(error)")
                }
                
            }
            
            self.tableView.reloadData()
            
            }
        alert.addTextField { (alertTextFeild) in
            textFeild = alertTextFeild
            alertTextFeild.placeholder = "Create New Item"
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    
    }
    
    
    
    func loadItems() {
        
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    
}
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(itemForDeletion)
                }
                
            }catch {
                print("Error deleting item \(error)")
            }
        }
    }

}


extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()


            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}
