//
//  ArrowTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class ArrowTrap : SKSpriteNode, Trap {
    
    let damage = 0.3
    var arrowWoosh: SKEmitterNode!
    
    init() {
        var arrowTrapState = Trapstate.Benign
        
        let texture = SKTexture(imageNamed: "arrowTrap")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //anchorPoint = CGPoint(x: 0, y: 0)
        /*
        var textures = [SKTexture]()
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "bearTrap\(i)"))
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever) 
         */
        
        arrowWoosh = SKEmitterNode(fileNamed: "ArrowWoosh")!
        arrowWoosh.targetNode = parent
        addChild(arrowWoosh)
        arrowWoosh.zPosition = 44
        name = "trap"
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}