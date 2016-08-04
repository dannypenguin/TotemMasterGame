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



class GameSceneCamera : SKScene, Scene, SKPhysicsContactDelegate, TotemDelegate {
    
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    
    
    var lifeBarFront: SKSpriteNode!
    
    var myCamera: SKCameraNode!
    var scoreCount: SKLabelNode!

    var trapNode: SKNode!
    var trapDictionary = [Totem: Trap]()
    var disarm: CGFloat = 0.0
    var trap:Trap?
    
    var reload = false
    var controller : Controller!
    var gamepro: GameProtocol!
    var terminateScene = false
    
    var makingFloor: [SKNode] = []
    var floorWidth: CGFloat = 568
    
    var nextTrap: Double = 0.0
    var nextBanana: NSTimeInterval = 0
    let cameraspeed: CGFloat = 2.0
    let cameraFactor: CGFloat = 100.0
    
    
    static let totalTimeRound = 60
    var timeCount: SKLabelNode!
    var gameOverTime: NSTimeInterval = 0
    var currentTime = 0
    
    var totemMaster: [Totem] = []
    var masterDan = Player()
    var sky = SkyTimer()
    var firedBanana = false
    
    
    
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
    var characterX: CGFloat = 2
    
    func setController(controller : GameProtocol) {
        self.gamepro = controller
    }
    
    
    override func didMoveToView(view: SKView) {
        
        floor1 = self.childNodeWithName("floor1") as! SKSpriteNode
        floor2 = self.childNodeWithName("floor2") as! SKSpriteNode
        
        scoreCount = self.childNodeWithName("//scoreCount") as! SKLabelNode
        
        lifeBarFront = self.childNodeWithName("//lifeBarFront") as! SKSpriteNode
        
        timeCount = self.childNodeWithName("//timeCount") as! SKLabelNode
        
        let now = NSDate().timeIntervalSince1970
        gameOverTime = now + Double(GameSceneCamera.totalTimeRound)
        updateTime()
        
        updateScore(0)
        
        
        trapNode = SKNode()
        addChild(trapNode)
        trapNode.position.y = view.frame.height/2
        trapNode.zPosition = 25
        trapNode.position.x = 0
        
        makingFloor = [floor1,floor2]
        
        myCamera = self.childNodeWithName("camera") as! SKCameraNode
        camera = myCamera
        
        myCamera.addChild(sky)
        sky.zPosition = -1
        sky.anchorPoint.x = 0.5
        sky.anchorPoint.y = 0.5
        

        
        physicsWorld.contactDelegate = self
        var totemy: CGFloat = -112
        let totemfront = createsTotem(totemy)
        totemy+=102
        let totemcenter = createsTotem(totemy)
        totemy+=102
        let totemback = createsTotem(totemy)
        
        
        totemMaster = [totemfront, totemcenter, totemback]
        
        self.addChild(masterDan)
        masterDan.position.x = frame.midX
        masterDan.position.y = frame.midY
        masterDan.zPosition = 50
        masterDan.anchorPoint.x = 0.5
        masterDan.anchorPoint.y = 0.5
        masterDan.setScale(0.9)
        
        //Handle Tap Gestures with the use of UIKit
        
        let fireBanana = UITapGestureRecognizer(target: self, action: #selector(GameSceneCamera.onTap(_:)))
        
        
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
        
        view.addGestureRecognizer(fireBanana)
    }
    
    func updateTime() -> Bool{
        let now = NSDate().timeIntervalSince1970
        let temp = Int(gameOverTime - now)
        if temp != self.currentTime {
             timeCount.text = String(temp)
            self.currentTime = temp
        }
        return self.currentTime == 0
    }
    
    func createsTotem(ypos: CGFloat) -> Totem {
        let totem = Totem()
        
        myCamera.addChild(totem)
        
        totem.position.x = -190
        totem.position.y = ypos
        totem.zPosition = 50
        totem.anchorPoint.x = 0.5
        totem.anchorPoint.y = 0.5
        totem.setScale(0.9)
        totem.delegate = self
        return totem
    }
    
    func onTap(gesture: UITapGestureRecognizer) {
        fireBanana()
    }
    
    func getTotemAtPlayer() -> Totem {
        return self.totemMaster[Int(characterY)]
    }
    
    func fireBanana() {
        var bananaPoint: CGPoint?
        var offset: CGFloat = frame.width
        var removeTrapAction: SKAction?
        if  gamepro.getScore() > 0 {
            let totem = getTotemAtPlayer()
            if let trap = trapDictionary[totem] {
                if trap.position.x < masterDan.position.x {
                    removeTrapAction = SKAction.runBlock({ 
                        self.removeTrap(trap)
                    })
                    bananaPoint = trap.position
                    offset = masterDan.position.x - trap.position.x
                }
            }
            let bananagun = BananaShot()
            self.addChild(bananagun)
            bananagun.position = masterDan.position
            bananagun.zPosition = masterDan.zPosition - 0.1
            //let totempos = bananaPoint ?? self.convertPoint(totem.position, fromNode: totem.parent!)
            let moveBanana = SKAction.moveByX(-offset, y: 0, duration: Double(offset/frame.width) * 0.5)
            firedBanana = true
            updateScore(1)
            
            
            let placateBoss = SKAction.runBlock({
                totem.placate()
            })
            //decide whether or not to placate boss or remove the trap
            
            let removeBanana = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([moveBanana,removeTrapAction ?? placateBoss, removeBanana])
            bananagun.runAction(sequence)
        }
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
        return isGone(masterDan)
    
    }
    
    func isGone(node: SKNode) -> Bool {
        let nodePosition = node.position
        let cameraPosition = myCamera.position
        let width = frame.width
        let edge = cameraPosition.x + width * 0.6
        
        return nodePosition.x > edge
        
    }
    
    func updateTraps() {
        var holdDictionary = [Trap]()
        for i in trapDictionary {
            if isGone(i.1) {
                holdDictionary.append(i.1)
            }
        }
        for j in holdDictionary {
            removeTrap(j)
        }
        
        let totempicker = totemMaster[random() % totemMaster.count]
        if totempicker.shouldAttack() {
            makeTrapForTotem(totempicker, powerup: false)
        }
    }
    
    
    func removeTrap(t: Trap) {
        var key: Totem?
        for i in trapDictionary {
            if i.1 == t {
                key = i.0
                break
            }
        }
        if let k = key {
            trapDictionary.removeValueForKey(k)
        }
        t.removeFromParent()
    }
    
    func updateScore(bonus: Int){
        if firedBanana == false {
        let newScore = gamepro.incrementScore(bonus)
        scoreCount.text = String(newScore)
        }
        else {
            let noScore = gamepro.setScoreGame(bonus)
            scoreCount.text = String(noScore)
            firedBanana = false
        }
    }
    
    func updateBananas() {
        let now = NSDate().timeIntervalSince1970
        if now > nextBanana {
            let totem = totemMaster[random() % totemMaster.count]
            if totem.anger <= 2 {
                self.makeTrapForTotem(totem, powerup: true)
                nextBanana = now + Double((arc4random() % 20))/10.0
            }
        }
        
    }
    


    override func update(currentTime: NSTimeInterval) {
        
        if updateTime() || isPlayerGone() || masterDan.isDead() {
            self.terminate()
            gamepro.gameOver()
        }
        if !terminateScene {
            let dx: CGFloat = CGFloat(gamepro.getScore()) / self.cameraFactor + cameraspeed
            myCamera.position.x -= dx
            scrollSceneNodes()
            updateTraps()
            updateBananas()
            
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
}




extension GameSceneCamera {
    // Check position of nodes as camera moves
    func scrollSceneNodes() {
        for node in makingFloor {
            let x = node.position.x - myCamera.position.x
            if x > view!.frame.width {
                node.position.x -= floorWidth * 2
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
            //print("Player Hit Trap")
            if contact.bodyA.node!.name == "trap" {
                trap = contact.bodyA.node as! SKSpriteNode
                player = contact.bodyB.node as! Player
            }
            else if contact.bodyB.node!.name == "trap" {
                trap = contact.bodyB.node as! SKSpriteNode
                player = contact.bodyA.node as! Player
            }
            
            if let check = trap as? Trap {
                let damageScale = player.takeDamage(check.damage())
                lifeBarFront.xScale = damageScale
                removeTrap(check)
                updateScore(check.scoreCounter())
                
            }
        }
        else if collision == PhysicsCategory.Player | PhysicsCategory.Totem {
            //print("Player Hit Totem")
        }
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
            trap = ArrowTrap()
        }
        return trap
    }
    
    func makeTrapForTotem(totem: Totem, powerup: Bool) {
        //var trap:Trap?
        //print("**** Make Trap for Delegate")
        if !powerup {
            if let _ = trapDictionary[totem] {
                return
            }
            let now = NSDate().timeIntervalSince1970
            if nextTrap > now {
                return
            }
            nextTrap = now + 2.0
            trap = makeTrap()
            trapDictionary[totem] = trap!
        } else {
            trap = YellowBanana()
        }
        if let t = trap {
            t.position.x = totem.position.x + myCamera.position.x
            t.position.y = totem.position.y
            trapNode.addChild(t)
        }
    }
}









