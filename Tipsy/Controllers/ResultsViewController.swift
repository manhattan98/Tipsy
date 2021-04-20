//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Eremej Sumcenko on 17.02.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    let formatter = NumberFormatter()
    
    var totalPerPerson: Float = 0.0
    var descriptionText: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.maximumFractionDigits = 2
        
        totalPerPersonLabel.text = formatter.string(from: NSNumber(value: totalPerPerson))
        descriptionLabel.text = descriptionText
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
