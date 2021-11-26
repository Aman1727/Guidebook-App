//
//  ViewController.swift
//  Guidebook App
//
//  Created by Aman on 26/11/21.
//

import UIKit

class ViewController: UIViewController {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //Get the places from core data
        do {
            places = try context.fetch(Place.fetchRequest())
        }catch {
            print("Couldn't fetch places from database...")
            return
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Double check that a row was selected
        if tableView.indexPathForSelectedRow == nil {
            return
        }
        
        // Get the selected place
        let selectedPlace = self.places[tableView.indexPathForSelectedRow!.row]
        
        
        // Get a reference to the place view controller
        let placeVC = segue.destination as! PlaceViewController
        
        // Set the place property
        placeVC.place = selectedPlace
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: Get a cell reference
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PLACE_CELL) as! PlaceTableViewCell
        
        //Get the place
        let p = self.places[indexPath.row]
        
        //Customize the cell for the place that we're trying to show
        cell.setCell(p)
        
        //Return the cell
        return cell
        
    }
  
}


