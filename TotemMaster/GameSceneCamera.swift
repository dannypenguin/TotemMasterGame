//
//  GameSceneCamera.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/28/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let Player: UInt32 = 0b1
    static let Trap: UInt32 = 0b10
    static let Totem: UInt32 = 0b100
    static let Part: UInt32 = 0b1000
}

protocol GameProtocol: class {
    func cycleScene()
}


class GameSceneCamera : SKScene, SKPhysicsContactDelegate, TotemDelegate {
    var myCamera: SKCameraNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!

    var trapNode: SKNode!
    var trapDictionary = ["arrowtrap":[7],
                      "beartrap":[10],
                      "fireTrap":[5]]
    
    var makingFloor: [SKNode] = []
    //var floorHeight: CGFloat = 568
    var floorWidth: CGFloat = 320
    var deathDealer: Int = 0
    var terminateScene = false
    var gamepro: GameProtocol!
    
    //var totemfront = Totem()
    //var totemcenter = Totem()
    //var totemback = Totem()
    
    // Make array of totems
    var totemMaster: [Totem] = []
    
    var masterDan = Player()
    var frameThird: CGFloat!
    var characterY: CGFloat = 1 {
        didSet {
            if characterY > 2 {
                characterY = 2
            }
            else if characterY < 0 {
                characterY = 0
            }
        }
    }
    var characterX: CGFloat = 0 {
        didSet {
            
        }
    }
    
    func setGameProtocol(pro: GameProtocol) {
        self.gamepro = pro
    }
   
    
    
    override func didMoveToView(view: SKView) {
        
        floor1 = self.childNodeWithName("floor1") as! SKSpriteNode
        floor2 = self.childNodeWithName("floor2") as! SKSpriteNode
        
        trapNode = SKNode()
        addChild(trapNode)
        trapNode.position.x = view.frame.width/2
        trapNode.zPosition = 25
        
        frameThird = view.frame.width / 3
        
        makingFloor = [floor1,floor2]
        
        myCamera = self.childNodeWithName("camera") as! SKCameraNode
        camera = myCamera
        
        physicsWorld.contactDelegate = self
        var totemy: CGFloat = -102
        var totemfront = createsTotem(totemy)
        totemy+=102
        var totemcenter = createsTotem(totemy)
        totemy+=102
        var totemback = createsTotem(totemy)
        

        

        
        totemMaster = [totemfront, totemcenter, totemback]
        
        self.addChild(masterDan)
        masterDan.position.x = frame.midX
        masterDan.position.y = frame.midY
        masterDan.zPosition = 50
        masterDan.anchorPoint.x = 0.5
        masterDan.anchorPoint.y = 0.5
        masterDan.zRotation = CGFloat(M_PI)
        masterDan.setScale(0.9)
        
        //Handles Swipe Gestures with the use of UIKit
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(GameSceneCamera.onSwipe(_:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneCamera.onSwipe(_:)))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneCamera.onSwipe(_:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneCamera.onSwipe(_:)))
        
        swipeLeft.direction = .Left
        swipeRight.direction = .Right
        swipeUp.direction = .Up
        swipeDown.direction = .Down
        
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)

    }
    
    func createsTotem(ypos: CGFloat) -> Totem {
        var totem = Totem()
        
        myCamera.addChild(totem)
        
        totem.position.x = -220
        totem.position.y = ypos
        totem.zPosition = 50
        totem.anchorPoint.x = 0.5
        totem.anchorPoint.y = 0.5
        //totem.zRotation = CGFloat(-M_PI/2)
        totem.setScale(0.9)
        totem.delegate = self
        return totem

    }
    
    func onSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Left:
            print("Move Left")
            characterX += 1
        case UISwipeGestureRecognizerDirection.Right:
            print("Move Right")
            characterX -= 1
        case UISwipeGestureRecognizerDirection.Up:
            print("Move Up")
            characterY -= 1
        case UISwipeGestureRecognizerDirection.Down:
            print("Move Down")
            characterY += 1
        default:
            print("Invalid Move")
        }
        
        moveCharacter()
    }
    
    func moveCharacter() {
        let y = 58 + characterY * 102
        let x = 142 * characterX + 71
        let moveAction  = SKAction.moveTo(CGPoint(x: x, y: y), duration: 0.2)
        masterDan.runAction(moveAction)
        
    }

    
    func damage() -> Int {
        return 0
    }
    
    func terminate() {
        terminateScene = true
        for i in totemMaster {
            i.terminate()
            
        }
    }
    
    func isPlayerGone() -> Bool {
        let playerPosition = masterDan.position
        let cameraPosition = myCamera.position
        let width = frame.width
        let edge = cameraPosition.x - width/2.0
        
        return playerPosition.x < edge
    
    }

    override func update(currentTime: NSTimeInterval) {
        
        if isPlayerGone() || masterDan.isDead() {
            self.terminate()
            gamepro.cycleScene()
        }
        if !terminateScene {
            myCamera.position.x += 2
            scrollSceneNodes()
        }
    }
    
  /*  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        //totemfront.placate()
        //totemcenter.placate()
        //totemback.placate()
    
    }*/
}




extension GameSceneCamera {
    // Check position of nodes as camera moves
    func scrollSceneNodes() {
        
        for node in makingFloor {
            let x = node.position.y - myCamera.position.x
            if x < -(floorWidth + view!.frame.width / 2) {
                node.position.x += floorWidth * 2
            }
        }
    }
}

extension GameSceneCamera {
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsCategory.Player | PhysicsCategory.Trap {
            var player: Player!
            var trap: SKSpriteNode!
            print("Player Hit Trap")
            if contact.bodyA.node!.name == "trap" {
                trap = contact.bodyA.node as! SKSpriteNode
                player = contact.bodyB.node as! Player
                //contact.bodyA.node?.removeFromParent()
            }
            else if contact.bodyB.node!.name == "trap" {
                trap = contact.bodyB.node as! SKSpriteNode
                player = contact.bodyA.node as! Player
                //contact.bodyB.node?.removeFromParent()
            }
            trap.removeFromParent()
            if let check = trap as? Trap {
                player.takeDamage(check.damage())
            }
        }
        else if collision == PhysicsCategory.Player | PhysicsCategory.Totem {
            print("Player Hit Totem")
        }
    }
}

extension GameSceneCamera {
    func makePart() -> SKSpriteNode {
        let partSize = CGSize(width: 50.0, height: 50.0)
        let part = SKSpriteNode(color: UIColor.redColor(), size: partSize)
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody!.categoryBitMask = PhysicsCategory.Part
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
        
        return part
        
    }
    
}



extension GameSceneCamera {
    func makeTrap() -> Trap {
        var trap: Trap
        let r = arc4random() % 5
        switch r {
        case 0:
            trap = BearTrap()
        case 1:
            trap = FireTrap()
        case 2:
            trap = DoorTrap()
        case 3:
            trap = ArrowTrap()
        default:
            trap = YellowBanana()
        }
        return trap
    }
    
    func makeTrapForTotem(totem: Totem) {
        print("**** Make Trap for Delegate")
        // make a trap 
        let trap = makeTrap() as! SKSpriteNode
        // position trap
        trap.position.x = totem.position.x
        trap.position.y = myCamera.position.y + view!.frame.height/2
        // add child with trap
        trapNode.addChild(trap)
    }
}









