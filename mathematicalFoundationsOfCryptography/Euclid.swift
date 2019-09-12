//
//  Euclid.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 09/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

class Euclid{
    
    //Наибольший общий делитель
    //Алгоритм Евклида
    //Greatest common divisor
    //Euclidean algorithm
    public func greatestCommonDivisor(_ firstNumber: Int, _ secondNumder: Int) -> Int {
        
        var (firstNumber, secondNumder) = (firstNumber, secondNumder)
        
        if let simpleGCD = simpleCasesGreatestCommonDivisor(firstNumber, secondNumder) {
            return simpleGCD
        }
        
        while secondNumder != 0 {
            (firstNumber,secondNumder) = (secondNumder, firstNumber % secondNumder)
        }
        
        return abs(firstNumber)
    }
    
    private func simpleCasesGreatestCommonDivisor(_ firstNumber: Int, _ secondNumder: Int) -> Int? {
        //НОД равных чисел это число
        if firstNumber == secondNumder {
            return firstNumber
        }
        
        //НОД числа и нуля число
        if firstNumber == 0 {
            return secondNumder
        }
        if secondNumder == 0 {
            return firstNumber
        }
        
        return nil
    }
    
    //Расширенный алгоритм Евклида
    //Алгоритм Кнута для нахождений линейного разложения НОД
    //aU+bV=d=(a,b)
    public func extendedEuclid(_ firstNumber: Int, _ secondNumber: Int) -> (Int,Int) {
        
        let firstNumber = firstNumber
        let secondNumder = secondNumber
        var (a, b, x0, x1) = (firstNumber,secondNumder,1,0)
        
        while b != 0 {
            (a, b, x0, x1) = (b, a%b, x1, x0 - (a/b)*x1)
        }
        let U = x0
        let V = (greatestCommonDivisor(firstNumber, secondNumder) - firstNumber*x0)/secondNumder
        return(U,V)
    }
    
    
    //отрисовка решения для польователя по лекции
    public func solution(_ view: UIView, firstNumber: Int, secondNumber: Int, numberColumn: Double ) -> UIScrollView {
        let heightView = Double(410) //высота занятого экрава компонентами в сториборде
        let widthView = Double(35) //отступ справа для скролл вью
         let height = Double(30) //высота ячейки в таблице
        
        let scrolView = UIScrollView()
        let widthScrolView = Double(view.frame.width) - 2*widthView
        let heightScrolView = Double(view.frame.height) - heightView - 30
        let contentView = UIView()
        var heightContentView = Double(0)
       
        let width = widthScrolView / numberColumn //ширина ячейки в табл
        let x : Double = 0
        var y : Double = 0
        var y2 : Double = 60
        
        var firstNumber = firstNumber
        var secondNumber = secondNumber
        var (a, b, x0, x1) = (firstNumber,secondNumber,1,0)

        //дорисовка двух правых пустых ячейк
        drawSolution(contentView: contentView, x: widthScrolView / numberColumn, y: y, width: width, height: height, result: "*")
        drawSolution(contentView: contentView, x: widthScrolView / numberColumn, y: y + height, width: width, height: height, result: "*")
        //отрисовка первого и второго столбца
        while secondNumber != 0 {
            drawSolution(contentView: contentView, x: x, y: y, width: width, height: height, result: String(firstNumber))
            drawSolution(contentView: contentView, x: widthScrolView / numberColumn, y: y2, width: width, height: height, result: String(firstNumber / secondNumber))
           
            y += height
            y2 += height
            heightContentView += height
            (firstNumber,secondNumber) = (secondNumber, firstNumber % secondNumber)
            //отрисовка двух левых нижних ячеек
            if secondNumber == 0 {
                drawSolution(contentView: contentView, x: x, y: y, width: width, height: height, result: String(firstNumber))
                drawSolution(contentView: contentView, x: x, y: y + height, width: width, height: height, result: String(secondNumber))
                heightContentView += height * 2
            }
        }
        
        //отрисовка тертьего столбца
        if numberColumn == 3{
            var y3 = Double(60)
            drawSolution(contentView: contentView, x: widthScrolView / numberColumn * 2, y: 0, width: width, height: height, result: "1")
            drawSolution(contentView: contentView, x: widthScrolView / numberColumn * 2, y: height, width: width, height: height, result: "0")
            while b != 0 {
                drawSolution(contentView: contentView, x: widthScrolView / numberColumn * 2, y: y3, width: width, height: height, result: "\(x0) - \(a/b)*\(x1) = \(x0 - (a/b)*x1)")
                (a, b, x0, x1) = (b, a%b, x1, x0 - (a/b)*x1)
                y3 += height
            }
        }
        
        scrolView.frame = CGRect(x: widthView, y: heightView, width: widthScrolView, height: heightScrolView)
        contentView.frame = CGRect(x: 0, y: 0, width: widthScrolView, height: heightContentView)
        scrolView.contentSize.height = contentView.frame.height // Or whatever you want it to be.
        scrolView.addSubview(contentView)
        view.addSubview(scrolView)
        return scrolView
    }
    
    //добавление данных на экран
    private func drawSolution(contentView: UIView, x: Double, y: Double, width: Double, height: Double, result: String){
        
        let borderWidth = CGFloat(0.5) //толщина рамки
        let column = UILabel()
        column.frame = CGRect(x: x, y: y, width: width, height: height)
        column.layer.borderWidth = borderWidth
        column.text = "\(result)"
        column.textAlignment = .center
        contentView.addSubview(column)
    }
    

}


