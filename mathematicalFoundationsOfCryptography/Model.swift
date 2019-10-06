//
//  Model.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 10/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class Model {
    public var name: String
    public var about: String
    public var seguaIdentifier: String
    
    init () {
        name = ""
        about = "by sergey_sedov"
        seguaIdentifier = ""
    }
    
    init(name: String, about: String, seguaIdentifier: String) {
        self.name = name
        self.about = about
        self.seguaIdentifier = seguaIdentifier
    }
    
    public static func returnArr() -> [Model] {
        var allAlgorithm = [Model]()
        let item = Model(name: "Алгоритм Евклида", about: "by sergey_sedov 1-я лекция", seguaIdentifier: "mainPageToEuclid")
        let item2 = Model(name: "Каноническое разложение числа \n Функция Эйлера", about: "by sergey_sedov 2-я лекция", seguaIdentifier: "mainPageToEulerAbdCDN")
        let item3 = Model(name: "Нахождение обатного элемента", about: "by sergey_sedov 3-я лекция", seguaIdentifier: "mainPageToInverseElement")
        let item4 = Model(name: "Решение сравненией (для простого и составного m)", about: "by sergey_sedov 3-я лекция", seguaIdentifier: "mainPageToDicisionComparisons")
        let item5 = Model(name: "Китайская теорема", about:"by sergey_sedov 4-я лекция" , seguaIdentifier: "mainPageToChineseTheorem")
        let item6 = Model(name: "Нахождение вычета", about: "by sergey_sedov 5-я лекция", seguaIdentifier: "mainPageToFindingDeduction")
        let item7 = Model(name: "Нахождение первообразного корня", about: "by sergey_sedov 5-я лекция", seguaIdentifier: "mainPageToAntiderivativeRoot")
        allAlgorithm.append(item)
        allAlgorithm.append(item2)
        allAlgorithm.append(item3)
        allAlgorithm.append(item4)
        allAlgorithm.append(item5)
        allAlgorithm.append(item6)
        allAlgorithm.append(item7)
        return allAlgorithm
    }
    
    
}

