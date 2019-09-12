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
    
    init () {
        name = ""
        about = "by sergey_sedov"
    }
    
    init(name: String, about: String) {
        self.name = name
        self.about = about
    }
    
    public static func returnArr() -> [Model] {
        var allAlgorithm = [Model]()
        let item = Model(name: "Алгоритм Евклида", about: "by sergey_sedov 1-я лекция")
        allAlgorithm.append(item)
       
        return allAlgorithm
    }
    
    
}

