//
//  Totem.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/22/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

protocol TotemDelegate: class {
    func makeTrapForTotem(totem: Totem, powerup: Bool)
}

enum TotemColor: String {
    case Red = "Gorilla1",
         Green = "Gorilla2",
         Black = "Gorilla3"
}

class Totem : SKSpriteNode {
    var anger: Int = -1 {
        didSet{
            if !terminated {
                self.texture = textures[anger]
                if anger == 2 {
                    if let delegate = delegate {
                        delegate.makeTrapForTotem(self, powerup:false)
                    }
                }
            }
        }
    }
    weak var delegate: TotemDelegate?
    var textures: [SKTexture]
    var timer: NSTimer?
    var terminated = false
    
    
    init() {
        
        let texture1 = SKTexture(imageNamed: "Gorilla3")
        let texture2 = SKTexture(imageNamed: "Gorilla2")
        let texture3 = SKTexture(imageNamed: "Gorilla1")
        textures = [texture1, texture2, texture3]
        
        super.init(texture: texture1, color: UIColor.clearColor(), size: texture1.size())
        cycleTotem()
        anger = 0
        zPosition = 5
        
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody!.categoryBitMask = PhysicsCategory.Totem
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false

        
   
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  

    func cycleTotem() {
        let interval = Double(15 + random() % 10)/10.0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: false)
    }
    
    /*func generatePos(pos: CGFloat) -> CGFloat {
        var offset = -scene!.size.height/4
        if pos < offset {
            return offset
        } else if pos > offset && pos < +offset {
            offset = scene!.size.height/2
            return offset
        } else {
            return offset = scene!.size.height/
        }
    }*/
    
    func terminate() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func placate() {
        if anger > 0 {
            anger = 0
        }
    }
    
    func timerCallBack() {
        cycleTotem()
        
        if !shouldAttack() {
            anger += 1
        }

    }
    
    func shouldAttack() -> Bool{
        return anger == 2
    }
}
    