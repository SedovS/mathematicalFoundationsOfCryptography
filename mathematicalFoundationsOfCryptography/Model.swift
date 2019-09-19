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
        allAlgorithm.append(item)
        allAlgorithm.append(item2)
       
        return allAlgorithm
    }
    
    
}

