//
//  PlaceViewController.swift
//  Guidebook App
//
//  Created by Aman on 26/11/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    //MARK: Variables and Properties
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    
    var place:Place?
    
    
    lazy var infoViewController:InfoViewController = {
        let infoVC =  self.storyboard?.instantiateViewController(withIdentifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        return infoVC
    }()
    
    lazy var mapViewController:MapViewController = {
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.MAP_VIEWCONTROLLER) as! MapViewController
        return mapVC
    }()
    
    lazy var notesViewController:NotesViewController = {
        let notesVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.NOTES_VIEWCONTROLLER) as! NotesViewController
        return notesVC
    }()
    
    //MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the image
        if place?.imageName != nil {
            self.placeImageView.image = UIImage(named: place!.imageName!)
        }
        
        //Set the name
        placeNameLabel.text = place?.name
        
        switchChildViewControllers(infoViewController)
    }
    
    //MARK: Methods
    private func switchChildViewControllers(_ childVC:UIViewController) {
        //Create an instance of the info view controller

        
        // Add it as a child view controller of this one
        addChild(childVC)
        
        // Add its view as a subview of the container view
        containerView.addSubview(childVC.view)
        
        // Set it's frame and sizing
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Indicate that its now a child view controller
        childVC.didMove(toParent: self)
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            switchChildViewControllers(infoViewController)
        case 1:
            switchChildViewControllers(mapViewController)
        case 2:
            switchChildViewControllers(notesViewController)
        default:
            switchChildViewControllers(infoViewController)
        }
        
    }
    
}
