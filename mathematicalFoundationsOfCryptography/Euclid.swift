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
        if firstNumber == secondNumder {
            return firstNumber
        }
        
        if firstNumber == 0 {
            return secondNumder
        }
        if secondNumder == 0 {
            return firstNumber
        }
        
        return nil
    }
    
}


