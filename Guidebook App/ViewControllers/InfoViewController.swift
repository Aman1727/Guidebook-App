//
//  InfoViewController.swift
//  Guidebook App
//
//  Created by Aman on 26/11/21.
//

import UIKit

class InfoViewController: UIViewController {

    //MARK:  Variables and Properties
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place:Place?
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = place?.summary
    }
    

}
