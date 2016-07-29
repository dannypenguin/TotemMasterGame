//
//  Coin.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/28/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class Coin : SKSpriteNode, Trap {
    
    var score:Int
    
    init() {
       
        score = 0
        let texture = SKTexture(imageNamed: "coin")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //anchorPoint = CGPoint(x: 0, y: 0)
        name = "trap"
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
