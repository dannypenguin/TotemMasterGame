//
//  GameScene.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/12/16.
//  Copyright (c) 2016 Danny Peng. All rights reserved.
//

import SpriteKit
import UIKit
/*
// This struct holds all physics categories
// Using a struct like this allows you to give each category a name.
// These physics categoriesa are also used to generate collisions
// and contacts in an easy and intuitive way, see comments below.
struct PhysicsCategory {
    static let None:    UInt32 = 0          // 00000
    static let Lose:  UInt32 = 0b1        // 00001
    static let Black:   UInt32 = 0b10       // 00010
    static let Coin:    UInt32 = 0b100      // 00100
    static let Floor:   UInt32 = 0b1000     // 01000
    static let PowerUp: UInt32 = 0b10000    // 10000
} */
class GameScene: SKScene, SKPhysicsContactDelegate, Trap {
    
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
            if characterY > 2 {
                characterY = 2
            }
            else if characterY < 0 {
                characterY = 0
            }
        }
    }
    var scrollFloor1: SKSpriteNode!
    var scrollFloor2: SKSpriteNode!
    let playerTest = Player()
    var totemFront = Totem()
    var totemCenter = Totem()
    var totemBack = Totem()
    
    
    
    
    //var fireTrapStatus = fireTrap.setTrapState(Trapstate.Benign)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        frameThird = view.frame.width / 3
        
        scrollFloor1 = self.childNodeWithName("scrollFloor1") as! SKSpriteNode
        scrollFloor2 = self.childNodeWithName("scrollFloor2") as! SKSpriteNode
        
        
        self.addChild(playerTest)
        playerTest.position.x = 160
        playerTest.position.y = 71
        playerTest.zPosition = 50
        playerTest.anchorPoint.x = 0.5
        playerTest.anchorPoint.y = 0.5
        
        self.addChild(totemFront)
        totemFront.position.x = 60
        totemFront.position.y = 497
        totemFront.zPosition = 50
        totemFront.anchorPoint.x = 0.5
        totemFront.anchorPoint.y = 0.5
       
        self.addChild(totemCenter)
        totemCenter.position.x = 160
        totemCenter.position.y = 497
        totemCenter.zPosition = 50
        totemCenter.anchorPoint.x = 0.5
        totemCenter.anchorPoint.y = 0.5
        
        self.addChild(totemBack)
        totemBack.position.x = 260
        totemBack.position.y = 497
        totemBack.zPosition = 50
        totemBack.anchorPoint.x = 0.5
        totemBack.anchorPoint.y = 0.5

        startTrapMachine()
        
        
        //Handles Swipe Gestures with the use of UIKit
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
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
       // playerTest.position.x = 80 * characterX + 80
       // playerTest.position.y = 142 * characterY + 71
        
       let x = 80 * characterX + 80
       let y = 142 * characterY + 71
        let moveAction  = SKAction.moveTo(CGPoint(x: x, y: y), duration: 0.2)
        playerTest.runAction(moveAction)

    }
    
    
    
    
    func makeTrap() {
        
        var trap: Trap
        
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
        
        self.addChild(trap as! SKNode)
        (trap as! SKNode).position.x = CGFloat(arc4random() % 3) * frameThird + (frameThird / 2)
        (trap as! SKNode).position.y = view!.frame.height + 60
        (trap as! SKNode).zPosition = 33
        
        
        let moveTrap = SKAction.moveToY(-60, duration: 4) // Speed of traps moveing down the screen
        let removeTrap = SKAction.removeFromParent()
        
        
        (trap as! SKNode).runAction(SKAction.sequence([moveTrap, removeTrap]))
        

    }
    
    func startTrapMachine() {
        let wait = SKAction.waitForDuration(4) // Frequency of traps appearing
        let block = SKAction.runBlock { 
            self.makeTrap()
        }
        let repeatTraps = SKAction.repeatActionForever(SKAction.sequence([wait, block]))
        runAction(repeatTraps)
    }
    
    
    // MARK: Trap protocol 
    
    func hide() {
        self.hidden = true
    }
    
    func damage() -> Int {
        return 10
    }
    func setTrapState() -> Trapstate {
        return Trapstate.Benign
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        totemFront.changeTotem()
        totemCenter.changeTotem()
        totemBack.changeTotem()
        //When called it will run the animation of respective traps.
        //self.runAction(SKAction(named: "SimpleFireTrap")!)
        //self.runAction(SKAction(named: "BearTrap")!)
        
        enumerateChildNodesWithName("trap") { (node, stop) in
            print(node)
        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        scrollNode(scrollFloor1, speed: 2)
        scrollNode(scrollFloor2, speed: 2)
        //scroll through where totems change and find all traps set the state accordingly.
    }
    
    func scrollNode(node: SKNode, speed: CGFloat) {
        node.position.y -= speed
        if node.position.y < -node.frame.height/2 {
            node.position.y += 2 * node.frame.height
        }
    }
}
