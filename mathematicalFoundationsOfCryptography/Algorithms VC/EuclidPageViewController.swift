//
//  AlgorithmEuclidViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 11/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class EuclidPageViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    
    @IBOutlet weak var showSolutionOutletButton: UIButton!
    @IBAction func showSolutionButton(_ sender: UIButton) {
        showSolution()
    }
    @IBAction func searchButton(_ sender: UIButton) {
            search()
    }
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        showSolutionOutletButton.isEnabled = false
    }
    
    
    func search() -> Void {
        resultLabel.text = ""
        guard let firstNumber = Int(firstTextField.text!) else {return}
        guard firstNumber != 0 else {return}
        guard let secondNumber = Int(secondTextField.text!) else {return}
        guard secondNumber != 0 else {return}
        
        showSolutionOutletButton.isEnabled = true
        scrollView.removeFromSuperview()
        view.endEditing(true) //убираем клавиатуру
        let euclid = Euclid()

        let gcd = euclid.greatestCommonDivisor(firstNumber, secondNumber)
        if segmentedControl.selectedSegmentIndex == 0 {
            resultLabel.text = "НОД \(firstNumber) и \(secondNumber) равен \(gcd)"
        } else {
            let extended = euclid.extendedEuclid(firstNumber, secondNumber)
            resultLabel.text = "\(firstNumber)U + \(secondNumber)V = d \n U=\(extended.0), V=\(extended.1), d=\(gcd)"
        }
    }
    
    private func showSolution() -> Void {
        guard let firstNumber = Int(firstTextField.text!) else {return}
        guard firstNumber != 0 else {return}
        guard let secondNumber = Int(secondTextField.text!) else {return}
        guard secondNumber != 0 else {return}
        
        let euclid = Euclid()
        showSolutionOutletButton.isEnabled = false
        if segmentedControl.selectedSegmentIndex == 0 {
            scrollView = euclid.solution(view, firstNumber: firstNumber, secondNumber: secondNumber, numberColumn: 2)
        } else {
            scrollView = euclid.solution(view, firstNumber: firstNumber, secondNumber: secondNumber, numberColumn: 3)
        }
    }

}
