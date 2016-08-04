//
//  SkyTimer.swift
//  MonkeyGatherer
//
//  Created by Danny Peng on 8/3/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class SkyTimer: SKSpriteNode {
    
    init() {
        
        let texture = SKTexture(imageNamed: "Sky1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        var textures = [SKTexture]()
        for i in 1...10 {
            textures.append(SKTexture(imageNamed: "Sky\(i)"))
        }
        
        let animateIn = SKAction.fadeInWithDuration(2)
        let animateOut = SKAction.fadeOutWithDuration(2)

        let animate = SKAction.animateWithTextures(textures, timePerFrame: 6)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    


