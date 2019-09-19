//
//  Algorithms.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 19/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class Algorithms {
    
    //Каноническое разложение числа на простые множители
    //a - каноническое разложение числа на простые множители
    // a = p1^k1 * p2^k2 * ... * ps^ks
    //return [Int] = [p1,p2,p3]
    public static func canonicalDecompositionNumber(_ number: Int) -> [Int] {
        
        var number = number
        var a = 3 //для проверки кратности 2-м есть отдельный цикл
        var array : [Int] = []
        
        if number == 0 {
            return []
        }
        
        //проверка кратности 2-м
        while (number % 2 == 0) {
            number = number / 2
            array.append(2)
        }
        
        while (a < number) {
            
            if (number % a == 0) {
                array.append(a)
                number = number / a
            } else {
                a += 2
            }
        }
        if number > 1 {
            array.append(number)
        }
        return array
    }
    
    //return String
    //return "p1^k1 x p2^k2 x ... x ps^ks"
    public static func cdnToString(_ number: Int) -> String {
        let array = canonicalDecompositionNumber(number)
        var stringResult = ""
        var b = 1
        
        if array.count == 1 {
           stringResult = "\(array[0])"// array[0] - число простое
            return stringResult
        }
        
        for i in stride(from: 1, to: array.count , by: 1) {
            if array[i] == array [i-1] {
                b += 1
            } else {
                stringResult += "\(array[i-1])^\(b) x "// array[i-1]^b *
                b = 1
            }
            if i == array.count - 1 {
                stringResult += "\(array[i])^\(b)" //array[last]^b
                b = 1
            }
        }
        return stringResult
    }
    
    //Функия Эйлера
    //Function Euler`s
    //функция Эйлера F(m) - кол-во чисел ряда 0,1..,m-1 взаимно простых с m
    //F(a) = (p1^k1 - p1^(k1-1)) * ... * (ps^ks - ps^(ks-1))
    //a - каноническое разложение числа на простые множители
    // a = p1^k1 * p2^k2 * ... * ps^ks
    public static func functionEulers(_ number: Int) -> Int {
        let number = number
        let array = canonicalDecompositionNumber(number)
        var result = 1
        var b = 1
        
        if array.count == 1 {
            result = result * (Int(pow(Double(array[0]), Double(b))) - Int(pow(Double(array[0]), Double(b-1)))) // result = result * array[0]^b - array[0]^(b-1)
            return result
        }
        
        for i in stride(from: 1, to: array.count , by: 1) {  //вместо i in 1...array.count
            if array[i] == array [i-1] {
                b += 1
            } else {
                result = result * (Int(pow(Double(array[i-1]), Double(b))) - Int(pow(Double(array[i-1]), Double(b-1)))) // result = result * array[i-1]^b - array[i-1]^(b-1)
                b = 1
            }
            
            if i == array.count - 1 {
                result = result * (Int(pow(Double(array[i]), Double(b))) - Int(pow(Double(array[i]), Double(b-1)))) // result = result * array[last]^b - array[last]^(b-1)
                b = 1
            }
        }
        return result
    }
    
}
