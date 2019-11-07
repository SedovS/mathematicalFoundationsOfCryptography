//
//  OrderGroupViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 06.11.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class OrderGroupViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func searchAddButton(_ sender: UIButton) {
        search(operation: "addition")
    }
    @IBAction func searchMultButton(_ sender: UIButton) {
        search(operation: "multiplication")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    private func search(operation: String){
      
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!), number != 0 else {return}
        view.endEditing(true)
        
        switch operation {
        case "addition":
            if number-1 == Algorithms.functionEulers(number) {
                resultLabel.text = "Порядок всех элементов равен \(number), т.к. \(number) простое число"
            }else {
                textResult(dictionary: Group.findOrderAdditionGroup(p: number))
            }
           // resultLabel.text = Group.findOrderAdditionGroup(p: number)
            break
        case "multiplication":
            textResult(dictionary: Group.findOrderMultiplicationGroup(p: number))
            break
        default:
            return
        }
        
    }
    
    private func textResult(dictionary: Dictionary<Int, Int>) -> Void {
        
        var text : String = ""
        for element in dictionary {
            text += "ord \(element.key) = \(element.value), "
        }
        text.removeLast(2)
        text += "."
        
        resultLabel.text = text
    }

}
