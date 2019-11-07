//
//  GroupOnSubgroupsViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 07.11.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class GroupOnSubgroupsViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func additionButton(_ sender: UIButton) {
        search(operation: "+")
    }
    @IBAction func multiplacationButton(_ sender: UIButton) {
        search(operation: "*")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
    private func search(operation: String) -> Void {
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!), number != 0 else {return}
        view.endEditing(true)
        
        switch operation {
        case "+":
            textResult(group: Group.decompositionGroupOnSubgroupsOnAddition(element: number))
            break
        case "*":
            textResult(group: Group.decompositionGroupOnSubgroupsOnMultiplication(element: number))
            
            break
        default:
            return
        }
    }
    
    private func textResult(group : Dictionary<Int, [[Int]]>) -> Void {
        
        let dict = group.sorted(by: { $0.key < $1.key})
        var result : String = ""
        
        for arrays in dict {
            result += "Подгруппа "
            result += "\(arrays.value) \n"
        }
        resultLabel.text = result
    }
}
