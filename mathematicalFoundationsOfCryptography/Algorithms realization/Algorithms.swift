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
    
    //Каноническое разложение числа на простые множители
    //a - каноническое разложение числа на простые множители
    // a = p1^k1 * p2^k2 * ... * ps^ks
    //return Dictionary<String, Int>  = [p1: k1,p2: k2]
    static public func canonicalDecompositionNumberToDictionary(_ number: Int) -> Dictionary<Int, Int> {
        
        var number = number
        var a = 3 //для проверки кратности 2-м есть отдельный цикл
        var dictionary : Dictionary<Int, Int> = [:]
        
        if number == 0 {
            return [:]
        }
        
        func addValue(_ key: Int){
            if dictionary[key] == nil {
                dictionary[key] = 1
            } else {
                dictionary[key]! += 1
            }
        }
        
        //проверка кратности 2-м
        while (number % 2 == 0) {
            number = number / 2
            addValue(2)
        }
        
        while (a < number) {
            
            if (number % a == 0) {
                addValue(a)
                number = number / a
            } else {
                a += 2
            }
        }
        if number > 1 {
            addValue(number)
        }
        return dictionary
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
        //let inverseElement = (pow(Double(a), Double(functionEulers(modul)-1))).truncatingRemainder(dividingBy: (Double(modul))) //(a^(F(m)-1))(mod m)
       
        let bigA = BInt(a)  //from class Swift-Big-Number-Core
        let bigModul = BInt(modul)
        let inverseElement = (bigA ** (functionEulers(modul)-1)) % bigModul //(a^(F(m)-1))(mod m)
        
        return Int(inverseElement)
    }
    
    //Решение сравений для простого M
    //return "x=..."
    static public func comparisonsSimpleM(inverseElement : Int, b : Int, modul : Int) -> String {
        let text = "X= \(b*inverseElement%modul) + \(modul)k, k∈Z"
        return text
    }
    
    //Решение сравений для составного M
    ////return "x1=... , x2 = ... , xd = .... "
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
    //return a^k(mod m)
    static public func findingDeductionSimple(a: Int, k: Int, modul: Int) -> Int {
        
        let newExp = k % (modul - 1) // k(mod m-1)
        let aDec = Int64(a)
        let result = Int(pow(Double(aDec), Double(newExp)).truncatingRemainder(dividingBy: Double(modul))) //aDec^newExp
        return result
    }
    
    //Нахождение вычета a^k(mod m) для составного m
    // m=p1*p2*...*pn
    //return a^k(mod m)
    static public func findingDeductionСomposite(a: Int, k: Int, modul: Int) -> String {
        
        //let arrModuls = canonicalDecompositionNumber(modul)
        var arrModuls = [Int]()
        var arrA = [Int]()
        let dictModuls = canonicalDecompositionNumberToDictionary(modul)
        for element in dictModuls {
            let mod = (Int(pow(Double(element.key), Double(element.value))))
            let newEl = Int(pow(Double(a),Double(k % (mod - 1)))) % mod
            arrA.append(newEl)
            arrModuls.append(mod)
        }
        /*
        for element in arrModuls {
            let newA = Int(pow(Double(a), Double(k % (element - 1)))) % element
            arrA.append(newA)
        }*/
        
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
                let x = Int((BInt(a) ** (c/el)) % modul) //(Int(pow(Double(a), Double(c/el)).truncatingRemainder(dividingBy: Double(modul))))
                if x == 1 {
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
        var result = "\(a)*x^\(exp) = \(b) (mod \(modul))\n"
        if a != 0 {
            guard let u = findInverseElement(a, modul) else {return "(\(a),\(modul))!=1, числа не взаимно простые"}
            b = (b * u % modul)
        }
        let betta = functionEulers(modul)
        
        let arr = antiderivativeRoot(modul: modul)
        if arr.count == 0 {
            return "\(modul) не имеет первообразных корней"
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
            guard let u = findInverseElement(exp, newModul) else {return "(\(exp),\(newModul))!=1, числа не взаимнопростые"}
            gamma = (gamma * u) % newModul
        }
        
        result += "x= \(baseInd)^(\(gamma)+\(newModul)k), k∈Z"
        return result
    }
    
    //решение степенного (показательного) уравнения, когда х стоит в степени
    //a^x = b (mod modul)
    //return "x = ..."
    static public func exponentialXComparison(a: Int, b: Int, modul: Int) -> String {
        
        let betta = functionEulers(modul)
        let arr = antiderivativeRoot(modul: modul)
        if arr.count == 0 {
            return "\(modul) не имеет первообразных корней"
        }
        let baseInd = arr[0]
        var result = "\(a)^x = \(b) (mod \(modul))\n"
        
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
        result += "x=\(gammaB) + \(newModul)k, k∈Z"
        return result
        
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
            let x = Int((BInt(base) ** gamma) % modul) //(Int(pow(Double(base),Double(gamma))) % modul)
            if x == number {
                return gamma
            }
        }
        return nil
    }
    
    
    
    //Нахождение символа Лежандра
    //
    //return String с ответом или ошибками
    static public func symbolLegendre(a: Int, p: Int) -> String {
        
        if p == 1 {return "Число \(a) является квадратичным вычетом по модулю \(p) \nСравнение x^2 = \(a)(mod\(p)) \n Имеет решение"}
        
        guard functionEulers(p) == (p-1) else{
            return "Модуль \(p) не простой. Воспользуйтксь символом Якоби"
        }
        
        let euclid = Euclid()
        guard euclid.greatestCommonDivisor(a, p) == 1 else{
            return "НОД (\(a),\(p)) != 1"
        }
        
        let result: Int = symbolLegendre(a: a, p: p)
        
        if result == 1 {
            return "Число \(a) является квадратичным вычетом по модулю \(p) \nСравнение x^2 = \(a)(mod\(p)) \n Имеет решение"
        } else if result == -1 {
            return "Число \(a) является квадратичным НЕвычетом по модулю \(p) \nСравнение x^2 = \(a)(mod\(p)) \n не имеет решений"
        }
        return "Что то работает не так(( "
    }
    
    //Нахождение символа Лежандра
    //
    //return 1 or -1
    static private func symbolLegendre(a: Int, p: Int) -> Int {
        
        var a = a % p
        let p = p
        var result: Int = 1
        
        if a < 0 {
            result *= criterionEuler(a: -1, p: p)
            a = abs(a)
        }
        
        let dictionary = canonicalDecompositionNumberToDictionary(a)
        for (key, value) in dictionary {
            if value % 2 == 0 {continue}
            else {
                if key == 2 {
                    result *= criterionEuler(a: 2, p: p)
                } else {
                    result *= qadraticLaw(q: key, p: p)
                    result *= helpLegrange(a: key, p: p)
                }
            }
        }
        
        return result
    }
    
    //Критерий Эйлера
    static private func criterionEuler(a: Int, p: Int) -> Int {
        // let remainder = Int(pow(Double(a), Double((p-1)/2)).truncatingRemainder(dividingBy: Double(p)))
        let remainder = Int((BInt(a) ** ((p-1)/2)) % p)
        if remainder == 1 {return 1}
        else {return -1}
    }
    
    //
    static private func helpLegrange(a: Int, p: Int) -> Int {
        let aa = a
        let pp = p
        let p = aa
        let a = pp % aa
        var result = 1
        
        let dictionary = canonicalDecompositionNumberToDictionary(a)
        
        for (key, value) in dictionary {
            if value % 2 == 0 {continue}
            else {
                if key == 2 {
                    result *= criterionEuler(a: 2, p: p)
                } else {
                    result *= qadraticLaw(q: key, p: p)
                    result *= helpLegrange(a: key, p: p)
                    //result *= criterionEuler(a: p%key, p: key)
                }
            }
        }
        
        return result
    }
    
    //Квадратичный закон взаимности
    static private func qadraticLaw(q: Int, p: Int) -> Int {
        return Int(pow(Double(-1), Double( ((p-1)/2) * ((q-1)/2) )))
    }
    
    //Нахождение символа Якоби
    //
    //return String с ответом или ошибками
    static public func symbolJacobi(a: Int, m: Int) -> String {
        let euclid = Euclid()
        guard euclid.greatestCommonDivisor(a, m) == 1 else{
            return "НОД (\(a),\(m)) != 1"
        }
        
        var result: Int = 1
        
        if functionEulers(m) == (m-1) {
            result = symbolLegendre(a: a, p: m)
        }
        
        result = symbolLegendre(a: a, p: m)
        if result == 1 {
            return "Число \(a) является квадратичным вычетом по модулю \(m) \nСравнение x^2 = \(a)(mod\(m)) \n Возможно имеет решение"
        }else if result == -1 {
            return "Число \(a) является квадратичным НЕвычетом по модулю \(m) \nСравнение x^2 = \(a)(mod\(m)) \n не имеет решений"
        }
        
        return "Что то работает не так(( "
    }
    
    
    //Нахожденеи символа Якоби
    //
    //return 1 or -1
    static private func symbolJacobi(a: Int, m: Int) -> Int {
    
        var result: Int = 1
        
        if functionEulers(m) == (m-1) {
            result = symbolLegendre(a: a, p: m)
            return result
        }
        
        let dictionary = canonicalDecompositionNumberToDictionary(m)
        
        for (key, _) in dictionary {
            result *= symbolLegendre(a: a, p: key)
        }
        return result
    }
    
}
