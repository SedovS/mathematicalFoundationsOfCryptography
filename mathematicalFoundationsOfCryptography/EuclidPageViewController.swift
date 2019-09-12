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
        if firstTextField.text != "" && secondTextField.text != "" {
            showSolution()
        }
    }
    @IBAction func searchButton(_ sender: UIButton) {
        if firstTextField.text != "" && secondTextField.text != "" {
            search()
        }
    }
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        showSolutionOutletButton.isEnabled = false
    }
    
    
    func search() -> Void {
        showSolutionOutletButton.isEnabled = true
        scrollView.removeFromSuperview()
        
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
    
    private func showSolution() -> Void {
        
        let euclid = Euclid()
        showSolutionOutletButton.isEnabled = false
        if segmentedControl.selectedSegmentIndex == 0 {
            scrollView = euclid.solution(view, firstNumber: Int(firstTextField.text!)!, secondNumber: Int(secondTextField.text!)!, numberColumn: 2)
        } else {
            scrollView = euclid.solution(view, firstNumber: Int(firstTextField.text!)!, secondNumber: Int(secondTextField.text!)!, numberColumn: 3)
        }
    }

}
