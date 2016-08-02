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
    case Red = "cowTotem3",
         Green = "cowTotem2",
         Black = "cowTotem1"
}

class Totem : SKSpriteNode {
    //var totemColor: TotemColor = .Black
    //var sureFire:Bool = false
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
        
        let texture1 = SKTexture(imageNamed: "cowTotem1")
        let texture2 = SKTexture(imageNamed: "cowTotem2")
        let texture3 = SKTexture(imageNamed: "cowTotem3")
        textures = [texture1, texture2, texture3]
        
        super.init(texture: texture1, color: UIColor.clearColor(), size: texture1.size())
        cycleTotem()
        anger = 0
        
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
    
    func terminate() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func placate() {
        if anger > 0 {
            anger -= 1
        }
    }
    
    func timerCallBack() {
        
        cycleTotem()
        if anger < 2 {
            anger += 1
         
        }
    }
    
    func shouldAttack() -> Bool{
        if anger == 0 {
            return false
        }
        else if anger > 0 && anger < 1 {
            return false
        }
        else if anger == 2 {
            return true
        }
        return false
    }
    
    

    
}
    