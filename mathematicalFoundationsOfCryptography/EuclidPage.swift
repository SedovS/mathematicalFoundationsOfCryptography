//
//  AlgorithmEuclidViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 11/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class EuclidPage: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var showSolutionOutletButton: UIButton!
    @IBAction func showSolutionButton(_ sender: UIButton) {
        let euclid = Euclid()
        if segmentedControl.selectedSegmentIndex == 0 {
             euclid.solution(view, firstNumber: Int(firstTextField.text!)!, secondNumber: Int(secondTextField.text!)!, sgc: false)
        } else {
            euclid.solution(view, firstNumber: Int(firstTextField.text!)!, secondNumber: Int(secondTextField.text!)!, sgc: true)
        }
        
    }
    @IBAction func searchButton(_ sender: UIButton) {
        if firstTextField.text != "" && secondTextField.text != "" {
            search()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        showSolutionOutletButton.isEnabled = true
    }
    
    func search() -> Void {
       
        view.endEditing(true) //убираем клавиатуру
        let euclid = Euclid()
        let gcd = euclid.greatestCommonDivisor(Int(firstTextField.text!)!, Int(secondTextField.text!)!)
        if segmentedControl.selectedSegmentIndex == 0 {
            resultLabel.text = "НОД \(firstTextField.text!) и \(secondTextField.text!) равен \(gcd)"
        } else {
            let extended = euclid.extendedEuclid(Int(firstTextField.text!)!, Int(secondTextField.text!)!)
            resultLabel.text = "\(firstTextField.text!)U + \(secondTextField.text!)V = d \n U=\(extended.0), V=\(extended.1), d=\(gcd)"
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
