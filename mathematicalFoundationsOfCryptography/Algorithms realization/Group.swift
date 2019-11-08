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
    static func findOrderMultiplicationGroup(p: Int) -> Dictionary<Int,Int> {
        let modul = p
        let euler = Algorithms.functionEulers(modul)
        let dictP = Algorithms.canonicalDecompositionNumberToDictionary(euler)
        
        var ord = 1 // ord a = 
        var dict = Dictionary<Int, Int>()
        let euckid = Euclid()
        
        for a in 1..<p {
            if euckid.greatestCommonDivisor(a, p) != 1 {
                continue
            }
            for p in dictP {

                for w in stride(from: p.value, through: 0, by: -1) {
                    let exp = euler/(Int(pow(Double(p.key), Double(w)))) // (functionEuler(p))/p1^w
                    
                    if Int((BInt(a) ** exp) % BInt(modul)) == 1{
                        let r = p.value - w
                        ord *= Int(pow(Double(p.key), Double(r)))
                       
                        break
                    }
                }
            }
            dict[a] = ord
            ord = 1
        }
        
        return dict
    }
    
    // Нахождение порядка всех элементов в группе по сложению
    static func findOrderAdditionGroup(p: Int) -> Dictionary<Int, Int> {
        
        let modul = p
        //let dictP = Algorithms.canonicalDecompositionNumberToDictionary(modul)
        var ord = 0 // ord a =
        var dict = Dictionary<Int, Int>()
        
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
            dict[a] = ord
            ord = 0
        }
        return dict
    }
    
    
    //Разложение группы на подгруппы по сумме
    //
    static func decompositionGroupOnSubgroupsOnAddition(element: Int) -> Dictionary<Int, [[Int]]> {
        
        var subgroups = Dictionary<Int, [[Int]]>()
        
        //Если число простое, то всего две подгруппы
        if element - 1 == Algorithms.functionEulers(element) {
            var array = [Int]()
            for a in 0..<element{
                array.append(a)
            }
            subgroups[1] = [array]
            subgroups[2] = [[0]]
            return subgroups
        }
        
        var orders = [Int]()
        
        for a in 1...element {
            for n in 1...element {
            
                if (a * n % element) == 0 {
                    
                    if orders.contains(n) {
                        break
                    }
                    orders.append(n)
                    subgroups[a] = [helpSubgroupsOnAddition(a: a, n: n, modul: element)]
                    subgroups[a]! += formationRelatedClassesAddition(subgroup: helpSubgroupsOnAddition(a: a, n: n, modul: element), element: element)
                    break
                }
            }
        }
        
        return subgroups
    }
    
    //Помогает сформировать подргуппу порядка n для элемента a ПО СУММЕ
    //i in 1...n
    //a*i
    private static func helpSubgroupsOnAddition(a: Int, n: Int, modul: Int) -> [Int] {
        var array = [Int]()
        
        for i in 1...n {
            array.append(a * i % modul)
        }
        
        return array
    }
    
    
    //Формирование смежных классов для каждой подгруппы по сложению
    private static func formationRelatedClassesAddition(subgroup: [Int], element: Int) -> [[Int]] {
        
        var result = [[Int]]()
        
        for i in 1..<(element / subgroup.count) {
            var temp = [Int]()
            
            for el in subgroup {
                temp.append((el + i) % element)
            }
            result.append(temp)
        }
    
        return result
    }

    //Разложение группы на подгруппы по произведению
    //
    static func decompositionGroupOnSubgroupsOnMultiplication(element: Int) -> Dictionary<Int, [[Int]]> {
        
        var subgroups = Dictionary<Int, [[Int]]>()
        
        var orders = [Int]()
        let euler = Algorithms.functionEulers(element)
        
        for a in 1..<element {
            for n in 1...euler {
                
                if (Int(BInt(a) ** n % BInt(element))) == 1 {
                    
                    if orders.contains(n) {
                        break
                    }
                    orders.append(n)
                    subgroups[a] = [helpSubgroupsOnAMultiplication(a: a, n: n, modul: element)]
                    subgroups[a]! += formationRelatedClassesMultiplication(subgroup: helpSubgroupsOnAMultiplication(a: a, n: n, modul: element), element: element)
                    break
                }
            }
        }
        
        return subgroups
    }
    
    //Помогает сформировать подргуппу порядка n для элемента a ПО ПРОИЗВЕДЕНИЮ
    //i in 1...n
    //a^i
    private static func helpSubgroupsOnAMultiplication(a: Int, n: Int, modul: Int) -> [Int] {
        var array = [Int]()
        
        for i in 1...n {
            array.append(Int(BInt(a) ** i % BInt(modul)))
        }
        
        return array
    }
    
    //Формирование смежных классов для каждой подгруппы по произведению
    private static func formationRelatedClassesMultiplication(subgroup: [Int], element: Int) -> [[Int]] {
        
        var result = [[Int]]()
        var count = 1
        let funEuler = Algorithms.functionEulers(element)
        let countRelatedClasses = funEuler / subgroup.count
        
        for i in 1..<element {
            if count == countRelatedClasses {
                break
            }
            
            let euclid = Euclid()
            if (euclid.greatestCommonDivisor(i, element) != 1 || subgroup.contains(i)){
                continue
            }
                
            var temp = [Int]()
            
            for el in subgroup {
                temp.append((el * i) % element)
            }
            result.append(temp)
            count += 1
        }
    
        return result
    }
    
}
