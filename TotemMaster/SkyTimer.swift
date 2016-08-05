//
//  SkyTimer.swift
//  MonkeyGatherer
//
//  Created by Danny Peng on 8/3/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class SkyTimer: SKNode {
    var skyTextures = [SKTexture]()
    let skyTextFront: SKSpriteNode
    let skyTextBack: SKSpriteNode
    var textureIndex: Int = 0
    
    init(textures: [String]) {
        for textureName in textures {
            let texture = SKTexture(imageNamed: textureName)
            skyTextures.append(texture)
        }
        
        skyTextFront = SKSpriteNode(texture: skyTextures[0])
        skyTextBack = SKSpriteNode(texture: skyTextures[1])
        
        print(skyTextFront)
        
        super.init()
        
        setup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addChild(skyTextFront)
        skyTextFront.zPosition = -1
        addChild(skyTextBack)
        skyTextBack.zPosition = -2
    }
    
    func startFade() {
        let fadeOut = SKAction.fadeOutWithDuration(5)
        let block = SKAction.runBlock {
            self.textureIndex += 1
            
            self.setTextures()
            self.startFade()
        }
        let fadeSeq = SKAction.sequence([fadeOut,block])
        
        skyTextFront.runAction(fadeSeq)
    }
    
    func setTextures() {
        let t1 = resetIndex(textureIndex)
        let t2 = resetIndex(textureIndex + 1)
        skyTextFront.alpha = 1
        skyTextFront.texture = skyTextures[t1]
        skyTextBack.texture = skyTextures[t2]
        print("This is t2 \(t2)" )
        
    }
    
    func resetIndex(index: Int) -> Int {
        return index % skyTextures.count
    }
    
    func stopFade() {
        removeAllActions()
    }

}

    


