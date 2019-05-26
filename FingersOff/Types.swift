//
//  Types.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

enum PhysicsCategory: UInt32 {
    case all = 4294967295
    case finger = 0b10
    case point = 0b1000
    case saw = 0b100
    
    // PowerUps
    case slowClock = 0b100000
    case removeSaw = 0b10000
    
    var powerUp: PowerUp? {
        switch self {
        case .slowClock: return .slowClock
        case .removeSaw: return .removeSaw
        default: return nil
        }
    }
}

enum PowerUp {
    case slowClock
    case removeSaw
}

enum GameState : Int {
    case playing
    case waitingStart
    case finished
}
