//
//  BearTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class BearTrap : SKSpriteNode, Trap {
    
    let damage = 0.3
    var spark: SKEmitterNode!
    
    init() {
        var bearTrapState = Trapstate.Benign
        
        let texture = SKTexture(imageNamed: "bearTrap2")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        var textures = [SKTexture]()
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "bearTrap\(i)"))
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
        
        spark = SKEmitterNode(fileNamed: "Spark")!
        addChild(spark)
        spark.zPosition = 44
        spark.position.x = 15
        spark.position.y = -5
        name = "trap"
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}