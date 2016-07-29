//
//  GameSceneCamera.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/28/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit



class GameSceneCamera : SKScene, SKPhysicsContactDelegate ,Trap, TotemDelegate {
    var myCamera: SKCameraNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    
    var makingFloor: [SKNode] = []
    var floorHeight: CGFloat = 568
    
    var totemfront = Totem()
    var totemcenter = Totem()
    var totemback = Totem()
    
    // Make array of totems
    var totemMaster: [Totem] = []
    
    var masterDan = Player()
    var frameThird: CGFloat!
    var characterX: CGFloat = 1 {
        didSet {
            if characterX > 2 {
                characterX = 2
            }
            else if characterX < 0 {
                characterX = 0
            }
        }
    }
    var characterY: CGFloat = 0 {
        didSet {
            
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        
        floor1 = self.childNodeWithName("floor1") as! SKSpriteNode
        floor2 = self.childNodeWithName("floor2") as! SKSpriteNode
        
        frameThird = view.frame.width / 3
        
        makingFloor = [floor1,floor2]
        
        myCamera = self.childNodeWithName("camera") as! SKCameraNode
        camera = myCamera
        
        myCamera.addChild(totemfront)
        totemfront.position.x = -100
        totemfront.position.y = 235
        totemfront.zPosition = 50
        totemfront.anchorPoint.x = 0.5
        totemfront.anchorPoint.y = 0.5
        totemfront.zRotation = CGFloat(-M_PI/2)
        totemfront.setScale(0.9)
        totemfront.delegate = self
        
        myCamera.addChild(totemcenter)
        totemcenter.position.x = 0
        totemcenter.position.y = 235
        totemcenter.zPosition = 50
        totemcenter.anchorPoint.x = 0.5
        totemcenter.anchorPoint.y = 0.5
        totemcenter.zRotation = CGFloat(-M_PI/2)
        totemcenter.setScale(0.9)
        totemcenter.delegate = self
        
        myCamera.addChild(totemback)
        totemback.position.x = 100
        totemback.position.y = 235
        totemback.zPosition = 50
        totemback.anchorPoint.x = 0.5
        totemback.anchorPoint.y = 0.5
        totemback.zRotation = CGFloat(-M_PI/2)
        totemback.setScale(0.9)
        totemback.delegate = self
        
        totemMaster = [totemfront, totemcenter, totemback]
        
        self.addChild(masterDan)
        masterDan.position.x = 160
        masterDan.position.y = 284
        masterDan.zPosition = 50
        masterDan.anchorPoint.x = 0.5
        masterDan.anchorPoint.y = 0.5
        masterDan.zRotation = CGFloat(-M_PI/2)
        masterDan.setScale(0.9)
        
        //Handles Swipe Gestures with the use of UIKit
        let swipeRight = UISwipeGestureRecognizer(target: self, action:"onSwipe:")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        
        swipeLeft.direction = .Left
        swipeRight.direction = .Right
        swipeUp.direction = .Up
        swipeDown.direction = .Down
        
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)

    }
    
    func onSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Left:
            print("Move Left")
            characterX -= 1
        case UISwipeGestureRecognizerDirection.Right:
            print("Move Right")
            characterX += 1
        case UISwipeGestureRecognizerDirection.Up:
            print("Move Up")
            characterY += 1
        case UISwipeGestureRecognizerDirection.Down:
            print("Move Down")
            characterY -= 1
        default:
            print("Invalid Move")
        }
        
        moveCharacter()
    }
    
    func moveCharacter() {
        let x = 80 * characterX + 80
        let y = 142 * characterY + 71 // masterDan.position.y
        let moveAction  = SKAction.moveTo(CGPoint(x: x, y: y), duration: 0.2)
        masterDan.runAction(moveAction)
        
    }
    

    func startTrapMachine() {
        var nextInterval = 2.0
        var timer = NSDate().timeIntervalSince1970
        var nextTime = 0.0
        
        var count = 0
        while(count < 5) {
            let thisTime = NSDate().timeIntervalSince1970
            if thisTime > nextTime {
                print("Next time! \(thisTime)")
                nextTime = thisTime + nextInterval
                count += 1
                
                if count > 1 {
                    nextInterval -= 0.5
                }
            }
            sleep(1)
        }
    }

    override func update(currentTime: NSTimeInterval) {
        myCamera.position.y += 2
        scrollSceneNodes()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        totemfront.placate()
        totemcenter.placate()
        totemback.placate()
    
    }
}




extension GameSceneCamera {
    // Check position of nodes as camera moves
    func scrollSceneNodes() {
        
        for node in makingFloor {
            let y = node.position.y - myCamera.position.y
            if y < -(floorHeight + view!.frame.height / 2) {
                node.position.y += floorHeight * 2
                addContentToSceneNode(node) // ****
            }
        }
    }
}

extension GameSceneCamera {
    func makeTrapForTotem(totem: Totem) {
        print("**** Make Trap for Delegate")
    }
}




extension GameSceneCamera {
    func addContentToSceneNode(node: SKNode) { // ****
        node.removeAllChildren()
        print("Reached")
        // Loop through totem array 
        // is this totem angry? 
        // make trap
        for totem in totemMaster {
            if totem.shouldAttack() {
                // Make a trap in the lane of this totem
                //totem.position.x
                var trap: Trap
                
                print("A trap has been made")
                switch arc4random() % 5 {
                case 0:
                    trap = BearTrap()
                case 1:
                    trap = FireTrap()
                case 2:
                    trap = ArrowTrap()
                case 3:
                    trap = DoorTrap()
                case 4:
                    trap = Coin()
                default:
                    trap = BearTrap()
                }
                
                (trap as! SKNode).position.x = totem.position.x
                (trap as! SKNode).position.y = 60
                (trap as! SKNode).zPosition = 33
                
                node.addChild(trap as! SKNode)
            }
        }
    }
}









