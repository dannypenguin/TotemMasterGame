//
//  Totem.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/22/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

enum TotemColor: String {
    case Red = "cowTotem3",
    Green = "cowTotem2",
    Black = "cowTotem1"
}

class Totem : SKSpriteNode {
    var totemColor: TotemColor = .Black
    
    init() {
        
        let texture1 = SKTexture(imageNamed: "cowTotem1")
        let texture2 = SKTexture(imageNamed: "cowTotem2")
        let texture3 = SKTexture(imageNamed: "cowTotem3")
        super.init(texture: texture1, color: UIColor.clearColor(), size: texture1.size())
       /*
        var textures = [SKTexture]()
        for i in 1...3 {
            textures.append(SKTexture(imageNamed: "cowTotem\(i)"))
        } */

    
        /*
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
        }
        */
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changeTotem() {
        if(totemColor == .Black) {
            let randColor = arc4random_uniform(2) //pick num from 0 and 1

            switch randColor {
            case 0:
                totemColor = .Red
                break;
            case 1:
                totemColor = .Green
                break;
            default:
                break;
            }
        }
        else {
            totemColor = .Black
        }
        
        self.texture = SKTexture(imageNamed: totemColor.rawValue)
    }
    
}
    