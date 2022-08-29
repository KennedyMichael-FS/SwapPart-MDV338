//
//  PartModels.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/14/22.
//

import Foundation

class cpu {
    
    var name: String
    var brand: String
    var link: String
    
    init(name: String, brand: String, link: String) {
        self.name = name
        self.brand = brand
        self.link = link
    }
    
}

class storageDevice {
    
    var name: String
    var type: String // As HDD or SSD
    var link: String
    
    init(name: String, type: String, link: String){
        self.name = name
        self.type = type
        self.link = link
    }
    
}

class gpu {
    
    var name: String
    var rank: Int
    var link: String
    
    init(name: String, rank: Int, link: String){
        self.name = name
        self.rank = rank
        self.link = link
    }
    
}

class ram {
    
    var name: String
    var rank: Int
    var link: String
    
    init(name: String, rank: Int, link: String){
        self.name = name
        self.rank = rank
        self.link = link
    }
    
}
