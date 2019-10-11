//
//  DecisionComparisonsViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 26/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DecisionComparisonsViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func searchButton(_ sender: UIButton) {
        result()
    }
    let scrollView = UIScrollView()
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        
    }
    
    private func result(){
        scrollView.removeFromSuperview()
        resultLabel.text = ""
        
        guard var a = Int(firstTextField.text!) else {return}
        guard var b = Int(secondTextField.text!) else {return}
        guard let modul = Int(thirdTextField.text!) else {return}
        guard a != 0 else {return}
        guard b != 0 else {return}
        guard modul != 0 else {return}
        view.endEditing(true) //убираем клавиатуру
        
        a = a % modul
        b = b % modul
        
        if let inverseElement = Algorithms.findInverseElement(a, modul) {
            //m простое
            resultLabel.text = Algorithms.comparisonsSimpleM(inverseElement: inverseElement, b: b, modul: modul)
        } else {
            //m составное
             compositeM(text: Algorithms.comparisonsCompoundM(a: a, b: b, modul: modul))
        }
    }
    
   
    private func compositeM(text: String) -> Void {
        label.removeFromSuperview()
        let contentView = UIView()
       
        label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()

        contentView.addSubview(label)
        let heightScrolView = view.frame.height - 310
        scrollView.frame = CGRect(x: 0, y: 310, width: view.frame.width, height: heightScrolView)
        contentView.frame = CGRect(x: ((view.frame.width / 2) - (label.frame.width / 2) + 5), y: 0, width: view.frame.width , height: label.frame.height)
        scrollView.contentSize.height = contentView.frame.height // Or whatever you want it to be.
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
}
