//
//  ExponentialComparisonViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 13.10.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ExponentialComparisonViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var equationLabel: UILabel!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var thirdTextField: UITextField!
    
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fourTextLabel: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!

    
    @IBAction func searchButton(_ sender: UIButton) {
        search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        fourLabel.isHidden = true
        fourTextLabel.isHidden = true
        equationLabel.text = "a^x = b (mod m)"
        self.segmentControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
    }
    
    private func search() -> Void {
        guard let a = Int(firstTextField.text!), a != 0 else {return}
        guard let b = Int(secondTextField.text!), b != 0 else {return}
        guard let mod = Int(thirdTextField.text!), mod != 0 else {return}

        if segmentControl.selectedSegmentIndex == 1 {
            guard let exp = Int(fourTextLabel.text!) else {return}
            if exp == 0 {return}
            view.endEditing(true)
            resultLabel.text = Algorithms.exponentialComparison(a: a, exponent: exp, b: b, modul: mod)
        } else {
            view.endEditing(true)
            resultLabel.text = Algorithms.exponentialXComparison(a: a, b: b, modul: mod)
        }
    }
    
    @objc func selectedValue(target: UISegmentedControl){
        if segmentControl.selectedSegmentIndex == 0 {
            resultLabel.text = ""
            cleanTextField()
            equationLabel.text = "a^x = b (mod m)"
            fourLabel.isHidden = true
            fourTextLabel.text = ""
            fourTextLabel.isHidden = true
            
        }
        if segmentControl.selectedSegmentIndex == 1 {
            resultLabel.text = ""
            cleanTextField()
            equationLabel.text = "a*x^n = b (mod m)"
            fourLabel.isHidden = false
            fourTextLabel.isHidden = false
        }
    }
    
    private func cleanTextField() -> Void {
        firstTextField.text = ""
        secondTextField.text = ""
        thirdTextField.text = ""
        fourTextLabel.text = ""
    }
    
}
