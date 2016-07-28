//
//  DoorTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/22/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class DoorTrap : SKSpriteNode, Trap {
    
    let damage = 0.3
    
    init() {
        var doorTrapState = Trapstate.Benign
        
        let texture = SKTexture(imageNamed: "trapDoor1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
         var textures = [SKTexture]()
         for i in 1...4 {
         textures.append(SKTexture(imageNamed: "trapDoor\(i)"))
         }
         
         let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
         let animateForever = SKAction.repeatActionForever(animate)
         runAction(animateForever)
        
        name = "trap"
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}