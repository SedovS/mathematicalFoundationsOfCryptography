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
    //return F(a)
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
    
    //Нахождение обратного элемента
    //По теореме эйлера
    //U=a^(F(m)-1)
    //Находится только когда НОД(a,m)=1
    //return U
    public static func findInverseElement(_ a: Int, _ modul: Int ) -> Int? {
        let euclid = Euclid()
        guard euclid.greatestCommonDivisor(a, modul) == 1 else {return nil}
        let inverseElement = (pow(Double(a), Double(functionEulers(modul)-1))).truncatingRemainder(dividingBy: (Double(modul))) //(a^(F(m)-1))(mod m)
        
        return Int(inverseElement)
    }
    
    //Решение сравений для простого M
    static public func comparisonsSimpleM(inverseElement : Int, b : Int, modul : Int) -> String {
        let text = "X= \(b*inverseElement%modul) + \(modul)k, k∈Z"
        return text
    }
    
    //Решение сравений для составного M
    static public func comparisonsCompoundM(a : Int, b : Int, modul : Int) -> String {
        let a = a % modul
        let b = b % modul
        let euclid = Euclid()
        let d = euclid.greatestCommonDivisor(a, modul)
        if b%d != 0 {
            return "d|b условие теоремы не выполняется, \n т.к. \(d) не делит нацело \(b) \n \(b)%\(d)=\(b%d) "
            
        }
        guard let inverseElement = Algorithms.findInverseElement(a/d, modul/d) else {
            return "Нельзя найти обратный элемент, (a=\(a),modul\(modul))!=1"
            
        }
        var text = ""
        for i in 0..<d {
            text += "X\(i + 1)= \((b/d)*inverseElement + ((i)*(modul/d))) + \(modul)k, k∈Z\n"
        }
        
        return text
        
    }
    
    //Китайская теорема об остатках
    //M = Multiplication (mi)
    //Mi = M / mi
    //yi = inverse(Mi)(mod mi)
    ////result = Summ((ai*Mi*yi(modM)))
    //return result
    public static func chineseRemeinderTheorem(arrayNumber: [Int], arrayModul: [Int]) -> String {
        
        var multiplicationModul = 1
        var resultX = 0
        
        for arr in arrayModul {
            multiplicationModul *= arr
        }
        
        //x = Summ((ai*Mi*yi(modM)))
        for i in 0..<arrayModul.count {
            let m = multiplicationModul / arrayModul[i]
            let y = findInverseElement((m%arrayModul[i]), arrayModul[i])
            guard let yi = y else {return ""}
            resultX += (arrayNumber[i]*m*yi)
            
        }
        return "X=\(resultX % multiplicationModul) + \(multiplicationModul)k, k∈Z"
    }
    
    //Нахождение вычета a^k(mod m) для простого m
    //
    static public func findingDeductionSimple(a: Int, k: Int, modul: Int) -> Int {
        
        let newExp = k % (modul - 1) // k(mod m-1)
        let aDec = Int64(a)
        let result = Int(pow(Double(aDec), Double(newExp)).truncatingRemainder(dividingBy: Double(modul))) //aDec^newExp
        return result
    }
    
    //Нахождение вычета a^k(mod m) для составного m
    // m=p1*p2*...*pn
    static public func findingDeductionСomposite(a: Int, k: Int, modul: Int) -> String {
        
        let arrModuls = canonicalDecompositionNumber(modul)
        var arrA = [Int]()
        
        for element in arrModuls {
            let newA = Int(pow(Double(a), Double(k % (element - 1)))) % element
            arrA.append(newA)
        }
        let result = chineseRemeinderTheorem(arrayNumber: arrA, arrayModul: arrModuls)
        if result == "" {return "Не удается посчитать по китайской теоремме, так НОД модулей \(arrModuls) не равен 1"}
        return result
    }
    
    
    //Нахождение первообразного корня (образуещего элемента)
    //
    //
    static public func antiderivativeRoot(modul: Int) -> [Int] {
        
        let c = functionEulers(modul)
        let arrC = canonicalDecompositionNumber(c) //c=p1*p2*...*pn
        var result = [Int]()
        
        for a in 1..<modul {
            var i: Int = 0
            let euclid = Euclid()
            for el in arrC {
                i += 1
                if euclid.greatestCommonDivisor(a, modul) != 1 {break}
                if (Int(pow(Double(a), Double(c/el)).truncatingRemainder(dividingBy: Double(modul)))) == 1 {
                    break
                }
                if i == arrC.count {
                    result.append(a)
                }
            }
        }
        return result
    }
    
    //решение степенного (показательного) уравнения
    //a*x^exp = b (mod modul)
    //return "x = ..."
    static public func exponentialComparison(a: Int, exponent: Int, b: Int, modul: Int) -> String {
       
        var b = b
        var exp = exponent
        
        if a != 0 {
            guard let u = findInverseElement(a, modul) else {return "(\(a),\(modul))!=1, числа не взаимно простые"}
            b = (b * u % modul)
        }
        let betta = functionEulers(modul)
        
        let arr = antiderivativeRoot(modul: modul)
        if arr.count == 0 {
            return "\(modul) не имеет первообразных корней \(arr)"
        }
        let baseInd = arr[0]
       
        guard var gamma = ind(base: baseInd, number: b, modul: modul) else {return "(\(b),\(modul))!=1, нельзя проиндексировать число \(b)"}
        let euclid = Euclid()
        let d = euclid.greatestCommonDivisor(exp, betta)
        if (gamma % d) != 0 {
            return "Ур-е не имеет решений, т.к d=\(d), \(gamma)|\(d) - не выполняется"
        }
        
        exp = exp / d
        gamma = gamma / d
        let newModul = modul / d
        
        if exp != 1 {
            guard let u = findInverseElement(exp, newModul) else {return "(\(exp),\(newModul))!=1, числа не взаимно простые"}
            gamma = (gamma * u) % newModul
        }
        
        return "x= \(baseInd)^(\(gamma)+\(newModul)k), k∈Z"
    }
    
    //решение степенного (показательного) уравнения, когда х стоит в степени
    //a^x = b (mod modul)
    //return "x = ..."
    static public func exponentialXComparison(a: Int, b: Int, modul: Int) -> String {
        
        let betta = functionEulers(modul)
        let arr = antiderivativeRoot(modul: modul)
        if arr.count == 0 {
            return "\(modul) не имеет первообразных корней \(arr)"
        }
        let baseInd = arr[0]
        
        guard var gammaA = ind(base: baseInd, number: a, modul: modul) else {return "(\(a),\(modul))!=1, нельзя проиндексировать число \(b)"}
        guard var gammaB = ind(base: baseInd, number: b, modul: modul) else {return "(\(b),\(modul))!=1, нельзя проиндексировать число \(b)"}
        let euclid = Euclid()
        let d = euclid.greatestCommonDivisor(gammaA, betta)
        if (gammaB % d) != 0 {
            return "Ур-е не имеет решений, т.к d=\(d), \(gammaB)|\(d) - не выполняется"
        }
        gammaA = gammaA / d
        gammaB = gammaB / d
        let newModul = betta / d
        
        if gammaA != 1 {
            guard let u = findInverseElement(gammaA, newModul) else {return "(\(gammaA),\(newModul))!=1, числа не взаимно простые"}
            gammaB = (gammaB * u) % newModul
        }
        
        return "x=\(gammaB) + \(newModul)k, k∈Z"
        
    }
    
    //Индекс числа
    //gamma = ind base number
    //base^gamma = number
    //return gamma or nil
    static private func ind(base: Int, number: Int, modul: Int) -> Int? {
        
        let euclid = Euclid()
        if euclid.greatestCommonDivisor(number,modul) != 1 {return nil}
        
        let beta = functionEulers(modul) - 1
        
        for gamma in 0...beta {
            if (Int(pow(Double(base),Double(gamma))) % modul) == number {
                return gamma
            }
        }
        return nil
    }
    
}
