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
    
    init(name: String, about: String, seguaIdentifier: String) {
        self.name = name
        self.about = about
        self.seguaIdentifier = seguaIdentifier
    }

    static public func getModel() -> [Model] {
        return [Model(name: "Алгоритм Евклида", about: "by sergey_sedov 1-я лекция", seguaIdentifier: "mainPageToEuclid"),
        Model(name: "Каноническое разложение числа \n Функция Эйлера", about: "by sergey_sedov 2-я лекция", seguaIdentifier: "mainPageToEulerAbdCDN"),
        Model(name: "Нахождение обатного элемента", about: "by sergey_sedov 3-я лекция", seguaIdentifier: "mainPageToInverseElement"),
        Model(name: "Решение сравненией (для простого и составного m)", about: "by sergey_sedov 3-я лекция", seguaIdentifier: "mainPageToDicisionComparisons"),
        Model(name: "Китайская теорема", about:"by sergey_sedov 4-я лекция" , seguaIdentifier: "mainPageToChineseTheorem"),
        Model(name: "Нахождение вычета", about: "by sergey_sedov 5-я лекция", seguaIdentifier: "mainPageToFindingDeduction"),
        Model(name: "Нахождение первообразного корня", about: "by sergey_sedov 5-я лекция", seguaIdentifier: "mainPageToAntiderivativeRoot")
        ]
    }

}

