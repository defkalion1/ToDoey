//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Defkalion on 12/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
        loadCategories()
        
    }
    
    
    //MARK: - TableView Datasoursce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    //MARK: - Data Manipulation Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories have been added yet"

        
        
        
        return cell
    }
    
    //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textFeild.text!
            
            self.save(category: newCategory)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            }
        
        alert.addTextField { (alertTextField) in
            textFeild = alertTextField
            alertTextField.placeholder = "Create New Category"
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
            
        }catch {
            
            print("Error Saving Category \(error)")
            
        }
     
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {

                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }

            }catch {

                print("Error deleting Category \(error)")

            }

        }
    }
    
}


