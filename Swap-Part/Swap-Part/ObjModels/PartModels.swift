//
//  PartModels.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/14/22.
//

import Foundation

class cpu {
    
    var name: String
    var numOfCores: Int
    var socket: String
    var tdp: Int // In watts
    var baseFreq: Int // In MHz
    
    init(name: String, numOfCores: Int, socket: String, tdp: Int, baseFreq: Int) {
        self.name = name
        self.numOfCores = numOfCores
        self.socket = socket
        self.tdp = tdp
        self.baseFreq = baseFreq
    }
    
}

/// Milestone 2: Must have all other object models here.
/// Currently, this includes GPU, RAM, storage, keyboard/mouse.
