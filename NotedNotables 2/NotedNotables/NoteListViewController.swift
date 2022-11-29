//
//  NoteListViewController.swift
//  NotedNotables
//
//  Created by Adam Rodrigues on 2022-11-08.
//

import UIKit
import CoreData
import SwipeCellKit

class NoteListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes = [Note]()
    
    @IBAction func addNoteButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddNote", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 85.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadNotes()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        let title: String = notes[indexPath.row].title ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let dateCreated: String = dateFormatter.string(from: notes[indexPath.row].dateCreated ?? Date.now)
        
        cell.textLabel?.text = dateCreated + ": " + title
        
        if let important = cell.textLabel?.text?.localizedCaseInsensitiveContains("important") {
            if important {
                cell.contentView.backgroundColor = UIColor.yellow
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNoteDetails", sender: self)
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NoteDetailsViewController
        if segue.identifier == "showNoteDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.note = self.notes[indexPath.row]
            }
        } else if segue.identifier == "showAddNote" {
            destinationVC.note = nil
        }
    }
    
    // MARK: - Access context methods
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("There was an error saving the context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadNotes() {
        do {
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            notes = try context.fetch(fetchRequest)
            notes.sort(by: {$0.dateCreated ?? Date.distantPast > $1.dateCreated ?? Date.distantPast})
        } catch {
            print("There was an error loading the data \(error)")
        }
    }

}

// MARK - swipe delete
extension NoteListViewController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {( _, indexPath) in
            
            self.context.delete(self.notes[indexPath.row])
            self.notes.remove(at: indexPath.row)
            self.saveContext()
        }
        
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
}

// MARK: search bar
extension NoteListViewController : UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        searchItems(searchText: searchText)
    }
    
    fileprivate func searchItems(searchText: String) {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let titlePredicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: false)
        
        fetchRequest.predicate = titlePredicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching items \(error)")
        }
        tableView.reloadData()
    }
}
