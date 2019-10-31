//
//  SymbolLegendreAndJacobiViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 13.10.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SymbolLegendreAndJacobiViewController: UIViewController {

    @IBOutlet weak var descroptionLabel: UILabel!
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var pTextField: UITextField!
    @IBAction func LegandreButton(_ sender: UIButton) {
        Legandre()
    }
    @IBAction func JacobiButton(_ sender: UIButton) {
        Jacobi()
    }
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        descroptionLabel.text = "Нахождение символа Лежандра и символа Якоби.\nПозволяет узнать есть ли такие х что бы сравнение x^2=a(mod p) выполнялось"
        resultLabel.text = ""
    }
    
    private func Legandre() -> Void {
        resultLabel.text = ""
        guard let a = Int(aTextField.text!), a != 0 else {return}
        guard let p = Int(pTextField.text!), p != 0 else {return}
        view.endEditing(true)
        resultLabel.text = Algorithms.symbolLegendre(a: a, p: p)
    }
    
    private func Jacobi() -> Void {
        resultLabel.text = ""
        guard let a = Int(aTextField.text!), a != 0 else {return}
        guard let p = Int(pTextField.text!), p != 0 else {return}
        view.endEditing(true)
        resultLabel.text = Algorithms.symbolJacobi(a: a, m: p)
    }

}
