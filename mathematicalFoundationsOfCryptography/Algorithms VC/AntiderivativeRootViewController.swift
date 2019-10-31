//
//  AntiderivativeRootViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 06/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AntiderivativeRootViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func searchButton(_ sender: Any) {
        search()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        // Do any additional setup after loading the view.
    }
    

    private func search() -> Void {
        resultLabel.text = ""
        guard let number = Int(numberTextField.text!) else {return}
        if number == 0 {return}
        
        view.endEditing(true)
        let arrResult = Algorithms.antiderivativeRoot(modul: number)
        if arrResult.count == 0 {
            resultLabel.text = "Первообразных корней для модуля \(number) не существует"
            return
        }
        
        resultLabel.text = "Первообразные корни для модуля \(number): \n \(arrResult) \n"
        resultLabel.text! += "Приведенная система вычетов U(\(number)) \n"
        
        resultLabel.text! += "{"
        for i in 0..<Algorithms.functionEulers(number) {
            resultLabel.text! += "\((BInt(arrResult[0]) ** i) % number)  "
            //resultLabel.text! += "\(Int(pow(Double(arrResult[0]), Double(i)).truncatingRemainder(dividingBy: Double(number)))), "
        }
        resultLabel.text?.removeLast()
        resultLabel.text?.removeLast()
        resultLabel.text! += "}"
        
    }
    

}
