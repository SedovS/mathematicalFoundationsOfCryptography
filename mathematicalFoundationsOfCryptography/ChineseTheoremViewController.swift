//
//  ChineseTheoremViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 27/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ChineseTheoremViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    let fieldView = UIView()
    var searchButton = UIButton()
    let resultLabel = UILabel()
    let pickerView = UIPickerView()
    let dataForPicker = [Int] (2...10)
    let pickerTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        droPickerView()
    }
    
    private func droPickerView() -> Void {
        let textLabel = UILabel()
        textLabel.text = "Выберите количество уравнений"
        textLabel.frame = CGRect(x: 50, y: 50, width: 250, height: 50)
        view.addSubview(textLabel)
        textLabel.textAlignment = .center
        
        pickerTextField.frame = CGRect(x: 50, y: 150, width: 50, height: 50)
        pickerTextField.borderStyle = .roundedRect
        view.addSubview(pickerTextField)
        
        pickerTextField.inputView = pickerView
        
    }
    
    private func drowField() -> Void {
         pickerView.isHidden = true
        fieldView.frame = CGRect(x: (view.frame.width - 320)/2, y: 70, width: 320, height: view.frame.height - 140)
        
        var y = 10
        let x1 = 65
        let x2 = 180
        let height = 35
        let wightTextField = 70
        
        for i in 1...3 {
            let numberTextField = UITextField()
            let modulTextField = UITextField()
            let xLabel = UILabel()
            let modulLabel = UILabel()
            let bracketLabel = UILabel()
            xLabel.frame = CGRect(x: 40, y: y, width: 25, height: height)
            xLabel.text = "Х="
            
            numberTextField.tag = i
            numberTextField.frame = CGRect(x: x1, y: y, width: wightTextField, height: height)
            numberTextField.borderStyle = .roundedRect
            numberTextField.keyboardType = .numberPad
            
            modulLabel.frame = CGRect(x: x1 + wightTextField, y: y, width: 45, height: height)
            modulLabel.text = "(mod"
            
            modulTextField.tag = 100 + i
            modulTextField.frame = CGRect(x: x2, y: y, width: wightTextField, height: height)
            modulTextField.borderStyle = .roundedRect
            modulTextField.keyboardType = .numberPad
            
            bracketLabel.frame = CGRect(x: x2 + wightTextField, y: y, width: 10, height: height)
            bracketLabel.text = ")"
            
            fieldView.addSubview(xLabel)
            fieldView.addSubview(numberTextField)
            fieldView.addSubview(modulLabel)
            fieldView.addSubview(modulTextField)
            fieldView.addSubview(bracketLabel)
            
            y += height+10
        }
        searchButton = UIButton(type: .roundedRect)
        searchButton.frame = CGRect(x: Int((fieldView.frame.width / 2) - 50), y: y, width: 100, height: height)
        searchButton.setTitle("Решить", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        searchButton.addTarget(self, action: #selector(search(sender:)), for: .touchUpInside)
        y += height
        resultLabel.frame = CGRect(x: 30, y: y, width: 260, height: 70)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        
        fieldView.addSubview(resultLabel)
        fieldView.addSubview(searchButton)
        view.addSubview(fieldView)
        
    }
    
    
    @objc func search(sender: UIButton){
        
        var arrNumber = [Int]()
        var arrModul = [Int]()
        resultLabel.text = ""
        
        for i in 1...3{
            
            let numberTextField = self.view.viewWithTag(i) as! UITextField
            let modulTextField = self.view.viewWithTag(100 + i) as! UITextField
            guard let number = Int(numberTextField.text!) else {return}
            guard let modul = Int(modulTextField.text!) else {return}
            arrNumber.append(number)
            arrModul.append(modul)
        }
        view.endEditing(true) //убираем клавиатуру
        
        resultLabel.text = "X=\(Algorithms.chineseRemeinderTheorem(arrayNumber: arrNumber, arrayModul: arrModul))"
      
    }
    
    
    //сколько компонентов выводить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //сколько строк к компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataForPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(dataForPicker[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = "\(dataForPicker[row])"
        pickerView.isHidden = true
        drowField()
    }
    
}
