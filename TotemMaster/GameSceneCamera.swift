//
//  GameSceneCamera.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/28/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class GameSceneCamera : SKScene {
    var myCamera: SKCameraNode!
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    var makingFloor: [SKNode] = []
    var floorHeight: CGFloat = 568
    var totemfront = Totem()
    var totemcenter = Totem()
    var totemback = Totem()
    var masterDan = Player()
    
    // make array of floor nodes
    // var for height of floor nodes
    
    override func didMoveToView(view: SKView) {
        
        floor1 = self.childNodeWithName("floor1") as! SKSpriteNode
        floor2 = self.childNodeWithName("floor2") as! SKSpriteNode
        
        makingFloor = [floor1,floor2]
        
        // add floor nodes to array
        
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
        
        myCamera.addChild(totemcenter)
        totemcenter.position.x = 0
        totemcenter.position.y = 235
        totemcenter.zPosition = 50
        totemcenter.anchorPoint.x = 0.5
        totemcenter.anchorPoint.y = 0.5
        totemcenter.zRotation = CGFloat(-M_PI/2)
        totemcenter.setScale(0.9)
        
        myCamera.addChild(totemback)
        totemback.position.x = 100
        totemback.position.y = 235
        totemback.zPosition = 50
        totemback.anchorPoint.x = 0.5
        totemback.anchorPoint.y = 0.5
        totemback.zRotation = CGFloat(-M_PI/2)
        totemback.setScale(0.9)
        
        self.addChild(masterDan)
        masterDan.position.x = 160
        masterDan.position.y = 284
        masterDan.zRotation = 50
        masterDan.anchorPoint.x = 0.5
        masterDan.anchorPoint.y = 0.5
        masterDan.zRotation = CGFloat(-M_PI/2)
        masterDan.setScale(0.9)
    }
    
    override func update(currentTime: NSTimeInterval) {
        myCamera.position.y += 2
        scrollSceneNodes()
    }
    
    func scrollNode(node: SKNode, speed: CGFloat) {
        node.position.y -= speed
        if node.position.y < -node.frame.height/2 {
            node.position.y += 2 * node.frame.height
        }
    }
    
}




extension GameSceneCamera {
    // Check position of nodes as camera moves
    func scrollSceneNodes() {
        
        for node in makingFloor {
            let y = node.position.y - myCamera.position.y
            if y < -(floorHeight + view!.frame.height / 2) {
                node.position.y += floorHeight * 2
                addContentToSceneNode(node)
            }
        }
    }
}






extension GameSceneCamera {
    func addContentToSceneNode(node: SKNode) {
        node.removeAllChildren()
        let box = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 30, height: 30))
        
        box.position.x = CGFloat(arc4random() % 200)
        box.position.y = CGFloat(arc4random() % 200)
        
        box.zPosition = 10
        
        print(box)
        
        node.addChild(box)
    }
}









