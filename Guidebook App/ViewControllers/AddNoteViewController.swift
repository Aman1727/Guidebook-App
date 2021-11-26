//
//  AddNoteViewController.swift
//  Guidebook App
//
//  Created by Aman on 27/11/21.
//

import UIKit
import CoreData

protocol AddNoteDelegate {
    func noteAdded()
}

class AddNoteViewController: UIViewController {

    //MARK: Variables and Properties
    var delegate:AddNoteDelegate?
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var textView: UITextView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var place:Place?
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        cardView.layer.shadowOpacity = 1
        
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Methods
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        //Create a new note
        //Configure the properties
        let n = Note(context: context)
        n.date = Date()
        n.text = textView.text
        n.place = place
    
        // Save the core data context
        appDelegate.saveContext()
        
        //Let the delegate know that the note was added
        delegate?.noteAdded()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
