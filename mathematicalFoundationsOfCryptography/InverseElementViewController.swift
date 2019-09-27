//
//  InverseElementViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 26/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class InverseElementViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var modulTextField: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        search()
    }
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    private func search() -> Void {
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!) else {return}
        guard let modul = Int(modulTextField.text!) else {return}
        guard number != 0 else {return}
        guard modul != 0 else {return}
        view.endEditing(true) //убираем клавиатуру
        
        guard let result = Algorithms.findInverseElement(number, modul) else {resultLabel.text = "(\(number),\(modul)) != 1 /n Нельзя найти обратный элемент "
            return
        }
        resultLabel.text = "Обратный элемент равен \n \(result)"
    }

    

}
