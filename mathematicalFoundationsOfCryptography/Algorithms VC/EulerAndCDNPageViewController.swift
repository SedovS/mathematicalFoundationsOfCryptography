//
//  EulerAndCDNPageViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 19/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class EulerAndCDNPageViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func searchButton(_ sender: UIButton) {
            search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
    }
    
    private func search() -> Void {
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!), number != 0 else {return}
        view.endEditing(true) //убираем клавиатуру
       
        if segmentControl.selectedSegmentIndex == 0 {
            resultLabel.text = Algorithms.cdnToString(number)
        } else {
            resultLabel.text = "\(Algorithms.functionEulers(number))"
        }
    }
    
}
