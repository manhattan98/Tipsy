//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var billTotalTextField: UITextField!
    
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var splitStepper: UIStepper!
    
    @IBOutlet weak var zeroPercentButton: UIButton!
    
    @IBOutlet weak var tenPercentButton: UIButton!
    
    @IBOutlet weak var twentyPercentButton: UIButton!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
    let splitFormatter = NumberFormatter()
    
    let splitDefault: Int = 0
    let percentsDefault: Float = 0.0
    let billTotalDefault: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        splitFormatter.maximumFractionDigits = 0
        
        setCalculateButtonActive(isActive: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "calculateSegue":
            let resultVC = segue.destination as! ResultsViewController
            resultVC.totalPerPerson = calculatePerPerson()
            resultVC.descriptionText = generateDescription()
        default:
            print("unknown segue: \(String(describing: segue.identifier))")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func billTotalFieldChanged(_ sender: UITextField) {
        setCalculateButtonActive(isActive: !(sender.text?.isEmpty ?? true))
    }
    
    @IBAction func splitStepperChanged(_ sender: UIStepper) {
        splitLabel.text = splitFormatter.string(from: NSNumber(value: sender.value))
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "calculateSegue", sender: self)
    }
    
    @IBAction func percentsButtonPressed(_ sender: UIButton) {
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        
        sender.isSelected = true
        
        billTotalTextField.endEditing(true)
    }
    
    func setCalculateButtonActive(isActive: Bool) {
        calculateButton.isEnabled = isActive
        if isActive {
            calculateButton.alpha = 1.0
        } else {
            calculateButton.alpha = 0.3
        }
    }
    
    
    func getPercents() -> Float {
        if zeroPercentButton.state == .selected {
            return 0.0
        } else if tenPercentButton.state == .selected {
            return 0.1
        } else if twentyPercentButton.state == .selected {
            return 0.2
        } else {
            return percentsDefault
        }
    }
    
    func getSplit() -> Int {
        return Int(splitStepper.value)
    }
    
    func getBillTotal() -> Float {
        return Float(billTotalTextField.text ?? String(billTotalDefault)) ?? billTotalDefault
    }
    
    func calculatePerPerson() -> Float {
        return getBillTotal() * (1.0 + getPercents()) / Float(getSplit())
    }
    
    func generateDescription() -> String {
        return "Split between \(getSplit()) people, with \(getPercents() * 100)% tip."
    }

}
