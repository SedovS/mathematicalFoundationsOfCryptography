//
//  Euclid.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 09/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

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
    
    public func simpleCasesGreatestCommonDivisor(_ firstNumber: Int, _ secondNumder: Int) -> Int? {
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
    
    //Расширенный алгоритм Эвклида
    //Алгоритм Кнута для нахождений линейного разложения НОД
    //aU+bV=d=(a,b)
    public func extendedEuclid(_ firstNumber: Int, _ secondNumder: Int) -> (Int,Int) {
        
        let firstNumber = firstNumber
        let secondNumder = secondNumder
        var (a, b, x0, x1) = (firstNumber,secondNumder,1,0)
        
        while b != 0 {
            (a, b, x0, x1) = (b, a%b, x1, x0 - (a/b)*x1)
        }
        let U = x0
        let V = (greatestCommonDivisor(firstNumber, secondNumder) - firstNumber*x0)/secondNumder
        return(U,V)
    }

}


