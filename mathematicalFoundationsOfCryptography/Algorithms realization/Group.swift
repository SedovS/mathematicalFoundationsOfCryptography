//
//  Basics.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 01.11.2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class Group {
    
    // Нахождение порядка всех элементов в группе по умножению
    //
    //
    static func findOrderMultiplicationGroup(p: Int) -> String {
        let modul = p
        let euler = Algorithms.functionEulers(modul)
        let dictP = Algorithms.canonicalDecompositionNumberToDictionary(euler)
        
        var ord = 1 // ord a =
        var result: String = ""
        
        for a in 1...euler {
            for p in dictP {
                //for w in p.value...0 {

                for w in stride(from: p.value, through: 0, by: -1) {
                    let exp = euler/(Int(pow(Double(p.key), Double(w)))) // (p-1)/p1^w
                    
                    if Int((BInt(a) ** exp) % BInt(modul)) == 1{
                        let r = p.value - w
                        ord *= Int(pow(Double(p.key), Double(r)))
                        // ????? mb  ?????
                       
                        break
                    }
                }
            }
            result += "ord\(a) = \(ord), "
            ord = 1
        }
        result.removeLast(2)
        result += "."
        return result
    }
    
    // Нахождение порядка всех элементов в группе по сложению
    static func findOrderAdditionGroup(p: Int) -> String {
        
        if p-1 == Algorithms.functionEulers(p) {
            return "Порядок всех элементов равен \(p), т.к \(p) простое число"
        }
        let modul = p
        //let dictP = Algorithms.canonicalDecompositionNumberToDictionary(modul)
        var result: String = ""
        var ord = 0 // ord a =
        
        for a in 1...modul {
        
            for n in 1...modul {
                
                if Euclid().greatestCommonDivisor(a, modul) == 1 {
                    ord = modul
                    break
                }
                
                if (a*n%modul) == 0 {
                    ord = n
                    break
                }
            }
            /*
            for p in dictP {
                
                if Euclid().greatestCommonDivisor(a, modul) == 1 {
                    ord += modul
                    break
                } else {
                    //for w in p.value...0 {
                    for w in stride(from: p.value, through: 0, by: -1){
                        let exp = modul/(Int(pow(Double(p.key), Double(w)))) // (modul)/p1^w

                        if (a * exp % modul) == 0 {
                            ord += exp
                            break
                        }
                        
                    }
                }
            } */
            result += "ord\(a) = \(ord), "
            ord = 0
        }
        result.removeLast(2)
        result += "."
        return result
    }
}
