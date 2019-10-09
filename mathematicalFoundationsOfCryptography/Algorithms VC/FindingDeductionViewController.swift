//
//  FindingDeductionViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 06/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class FindingDeductionViewController: UIViewController {

    @IBAction func searchButton(_ sender: UIButton) {
        search()
    }
    @IBOutlet weak var modulTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var exponentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""

    }
    
    private func search() -> Void {
        
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!) else {return}
        guard let modul = Int(modulTextField.text!) else {return}
        guard let exponent = Int(exponentTextField.text!) else {return}
        if number == 0 || modul == 0 || exponent == 0 {return}
        view.endEditing(true) //убираем клавиатуру
        
        if Algorithms.functionEulers(modul) == modul-1 {
            resultLabel.text = "\(Algorithms.findingDeductionSimple(a: number, k: exponent, modul: modul)) (mod \(modul))"
        } else {
            resultLabel.text = Algorithms.findingDeductionСomposite(a: number, k: exponent, modul: modul)
        }
        
    }

}
