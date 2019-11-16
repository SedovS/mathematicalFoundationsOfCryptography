//
//  PrimeNumberViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 16.11.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PrimeNumberViewController: UIViewController {

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
        guard let number = Int(numberTextField.text!), number != 0 else { return }
        view.endEditing(true)
        
        let dataArray = Algorithms.sieveOfEratosthenes(number: number)
        
        resultLabel.text = "Простые числа до \(number)\n"
        for index in 2..<dataArray.count {
            if dataArray[index] {
                resultLabel.text! += "\(index), "
            }
        }
        resultLabel.text?.removeLast(2)
        
    }
}
