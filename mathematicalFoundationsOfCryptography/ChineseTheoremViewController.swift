//
//  ChineseTheoremViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 27/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ChineseTheoremViewController: UIViewController {
    
    var secondView = UIView()
    let firstView = UIView()
    
    let resultLabel = UILabel() //Показывает ответ
    let picker = UIPickerView()
    
    let dataForPicker = [2,3,4,5,6,7,8] //возвоможное кол-во уравнений
    var countEquations = 2 //значение уравнений по умолчанию
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        droPickerView()
    }
    
    private func droPickerView() -> Void {
        
        let textLabel = UILabel()
        textLabel.text = "Выберите количество уравнений"
        textLabel.numberOfLines = 0
        textLabel.frame = CGRect(x: 50, y: 80, width: view.frame.width - 100, height: 50)
        textLabel.textAlignment = .center
        
        picker.center = view.center
       
        firstView.addSubview(textLabel)
        view.addSubview(picker)
        view.addSubview(firstView)
    }
    
    private func drowField(countElement: Int) -> Void {
        firstView.removeFromSuperview()
        picker.removeFromSuperview()
        
        secondView.frame = CGRect(x: (view.frame.width - 320)/2, y: 70, width: 320, height: view.frame.height - 140)
        var searchButton = UIButton()
        var resetButton = UIButton()
        var backButton = UIButton()
        
        var y = 10
        let x1 = 70
        let x2 = 185
        let height = 35
        let wightTextField = 70
        
        for i in 1...countElement {
            let numberTextField = UITextField()
            let modulTextField = UITextField()
            let xLabel = UILabel()
            let modulLabel = UILabel()
            let bracketLabel = UILabel()
            xLabel.frame = CGRect(x: x1 - 25, y: y, width: 25, height: height)
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
            
            secondView.addSubview(xLabel)
            secondView.addSubview(numberTextField)
            secondView.addSubview(modulLabel)
            secondView.addSubview(modulTextField)
            secondView.addSubview(bracketLabel)
            
            y += height+10
        }
        searchButton = UIButton(type: .roundedRect)
        searchButton.frame = CGRect(x: Int((secondView.frame.width / 2) - 50), y: y, width: 100, height: height)
        searchButton.setTitle("Решить", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        searchButton.addTarget(self, action: #selector(search(sender:)), for: .touchUpInside)
        resetButton = UIButton(type: .roundedRect)
        resetButton.frame = CGRect(x: Int((secondView.frame.width / 2) - 50 + searchButton.frame.width), y: y, width: 100, height: height)
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backButton = UIButton(type: .roundedRect)
        backButton.frame = CGRect(x: Int((secondView.frame.width / 2) - 50 - searchButton.frame.width), y: y, width: 100, height: height)
        backButton.setTitle("Кол-во", for: .normal)
        backButton.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        y += height
        resultLabel.frame = CGRect(x: 0, y: y, width: Int(secondView.frame.width), height: 90)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        
        secondView.addSubview(resultLabel)
        secondView.addSubview(searchButton)
        secondView.addSubview(resetButton)
        secondView.addSubview(backButton)
        view.addSubview(secondView)
    }
    
    @objc func search(sender: UIButton){
        
        var arrNumber = [Int]()
        var arrModul = [Int]()
        
        for i in 1...countEquations{
            let numberTextField = self.view.viewWithTag(i) as! UITextField
            let modulTextField = self.view.viewWithTag(100 + i) as! UITextField
            guard let number = Int(numberTextField.text!) else {return}
            guard let modul = Int(modulTextField.text!) else {return}
            arrNumber.append(number)
            arrModul.append(modul)
        }
        view.endEditing(true) //убираем клавиатуру
        let result = Algorithms.chineseRemeinderTheorem(arrayNumber: arrNumber, arrayModul: arrModul)
        if result == 0 {
            resultLabel.text = "Модули уравнения должны быть взаимно простыми, т.е. их НОД=1. К сожалению, сейчас данное условаие не выполняется. Измените значения"
        } else {
             resultLabel.text = "X=\(result)"
        }
    }
    
    @objc func reset(sender: UIButton){
        for i in 1...countEquations{
            let numberTextField = self.view.viewWithTag(i) as! UITextField
            let modulTextField = self.view.viewWithTag(100 + i) as! UITextField
            numberTextField.text = ""
            modulTextField.text = ""
        }
        resultLabel.text = ""
    }
    
    @objc func back(sender: UIButton){
        secondView.removeFromSuperview()
        secondView = UIView()
        countEquations = 2
        droPickerView()
    }
    
}

extension ChineseTheoremViewController : UIPickerViewDataSource {
    
    //сколько компонентов выводить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //сколько строк к компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataForPicker.count
    }
}

extension ChineseTheoremViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(dataForPicker[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countEquations = dataForPicker[row]
        drowField(countElement: dataForPicker[row])
    }
}

