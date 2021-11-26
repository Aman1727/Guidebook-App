//
//  NotesViewController.swift
//  Guidebook App
//
//  Created by Aman on 26/11/21.
//

import UIKit
import CoreData

class NotesViewController: UIViewController,AddNoteDelegate {
    
    //MARK:  Variables and Properties
    @IBOutlet weak var tableView: UITableView!
    var place:Place?
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes = [Note]()
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var fetchedNotesRC:NSFetchedResultsController<Note>?
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       refresh()
    }
    
    func refresh() {
        //Check if there's a place set
        if let place = place {
            //Get fecth request for the place
            let request = Note.fetchRequest()
            request.predicate = NSPredicate(format: "place = %@",place)
            // Set a sort descriptor for it
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            do{
                // Create a fetched results controller
                fetchedNotesRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                // Execute the fetch
                try fetchedNotesRC!.performFetch()
                    
            }catch {}
            
            //Tell table view to request data
            tableView.reloadData()
            
        }
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        
        //Display the popup
        
        let addNoteVC = storyboard?.instantiateViewController(withIdentifier: Constants.ADDNOTES_VIEWCONTROLLER) as! AddNoteViewController
        
        //Set self as delegate so we can get note notified of a new note being added
        addNoteVC.delegate = self
        
        //Pass the place object through
        addNoteVC.place = place
        
        //Configure the popup mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        //Present it
        present(addNoteVC, animated: true, completion: nil)
        
    }
    
    func noteAdded() {
        refresh()
    }
    
    
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedNotesRC?.fetchedObjects?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NOTE_CELL, for: indexPath)
        //Get references to the labels
        let datelabel = cell.viewWithTag(1) as! UILabel
        let notelabel = cell.viewWithTag(2) as! UILabel
        
        //Get the note for this indexpath
        let note = fetchedNotesRC?.object(at: indexPath)
        
        if let note = note {
            
            let df = DateFormatter()
            df.dateFormat = "MMM d, yyyy - h:mm a"
            
            datelabel.text = df.string(from: note.date!)
            notelabel.text = note.text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete")
        { (action, view, nil) in
            
            if self.fetchedNotesRC == nil {
                return
            }
            
            //Get a reference to the note to be deleted
            let n = self.fetchedNotesRC!.object(at: indexPath)
            //Pass it to the core data context delete method
            self.context.delete(n)
            
            self.appDelegate.saveContext()
            
            self.refresh()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
}
