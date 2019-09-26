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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        
    }
    
    private func result(){
        view.endEditing(true) //убираем клавиатуру
        scrollView.removeFromSuperview()
        resultLabel.text = ""
        
        guard var a = Int(firstTextField.text!) else {return}
        guard var b = Int(secondTextField.text!) else {return}
        guard let modul = Int(thirdTextField.text!) else {return}
        guard a != 0 else {return}
        guard b != 0 else {return}
        guard modul != 0 else {return}
        
        a = a % modul
        b = b % modul
        
        if let inverseElement = Algorithms.findInverseElement(a, modul) {
            //m простое
            resultLabel.text = "\(b*inverseElement%modul) + \(modul)k, k∈Z"
        } else {
            //m составное
            scroll(a: a, b: b, modul: modul)
        }
    }
    
    private func scroll(a : Int, b : Int, modul : Int) -> Void {
        let euclid = Euclid()
        let d = euclid.greatestCommonDivisor(a, modul)
        if b%d != 0 {
            resultLabel.text = "d|b условие теоремы не выполнятеся, \n т.к. \(d) не делит нацело \(b) \n \(b)%\(d)=\(b%d) "
            return
        }
        
        let contentView = UIView()
        let width = view.frame.width
        let height = 21
        var y = 0
        for i in 0..<d {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: y, width: Int(width), height: height)
            y += height + 2
            label.text = "X\(i + 1)= \(b/d + ((i)*(modul/d))) + \(modul)k, k∈Z\n"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            contentView.addSubview(label)
        }
        
        let widthScrolView = view.frame.width - 2*20
        let heightScrolView = view.frame.height - 310
        scrollView.frame = CGRect(x: 20, y: 310, width: widthScrolView, height: heightScrolView)
        contentView.frame = CGRect(x: 0, y: 0, width: Int(widthScrolView), height: y)
        scrollView.contentSize.height = contentView.frame.height // Or whatever you want it to be.
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }

   

}
