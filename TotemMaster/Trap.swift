//
//  Trap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class Trap: SKSpriteNode {
    
    var damageCounter = 0
    var score = 0
    
    func damage() -> Int {
        return damageCounter
    }
    func scoreCounter() -> Int {
        return score
    }
    
}




