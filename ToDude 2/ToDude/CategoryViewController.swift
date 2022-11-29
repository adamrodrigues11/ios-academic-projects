//
//  CategoryViewController.swift
//  ToDude
//
//  Created by Adam Rodrigues on 2022-11-08.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    
    @IBAction func addCategoryButtonTapped(_ sender: UIBarButtonItem) {
        var tempTextField = UITextField()
        
        let alertController = UIAlertController(title: "Add New Category:", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Done", style: .default) {(action) in
            let newCategory = Category(context: self.context)
            if let text = tempTextField.text {
                newCategory.name = text
                self.categories.append(newCategory)
                self.saveContext()
            }
        }
        alertController.addTextField {(textField) in
            textField.placeholder = "Category"
            tempTextField = textField
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCategories()
        tableView.rowHeight = 85.0
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = categories[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItems", sender: self)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.category = self.categories[indexPath.row]
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Context access methods
    func saveContext(){
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching items \(error)")
        }
        tableView.reloadData()
    }
}

extension  CategoryViewController : SwipeTableViewCellDelegate {
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {( _, indexPath) in
            
            self.context.delete(self.categories[indexPath.row])
            self.categories.remove(at: indexPath.row)
            self.saveContext()
        }
        
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
}
