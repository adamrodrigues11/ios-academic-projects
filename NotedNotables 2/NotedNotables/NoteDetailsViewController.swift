//
//  NoteDetailsViewController.swift
//  NotedNotables
//
//  Created by Adam Rodrigues on 2022-11-09.
//

import UIKit
import CoreData

class NoteDetailsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var note: Note?
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func saveNoteButtonTapped(_ sender: UIBarButtonItem) {
        if note == nil {
            note = Note(context: context)
            note!.dateCreated = Date.now // only set date if creating a new note
        }
        
        note!.title = titleTextField.text != "" ? titleTextField.text : "Untitled Note"
        
        note!.body = bodyTextView.text
        
        self.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }

    @IBAction func deleteButtonIsTapped(_ sender: UIButton) {
        guard note != nil else {return}
        
        self.context.delete(self.note!)
        self.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if note == nil {
            self.title = "Create A New Note"
        }
        else {
            self.title = "Note Details"
            titleTextField.text = note!.title
            bodyTextView.text = note!.body
        }
    
    }
    
    
    // MARK: - Context Access Methods
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("There was an error saving the context \(error)")
        }
    }
    
}
