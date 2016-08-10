//
//  TutorialScene.swift
//  MonkeyGatherer
//
//  Created by Danny Peng on 8/9/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene, Scene {
    var controller: GameProtocol!
    var nextSlide: Int = 0
    var textures = [SKTexture]()
    var holder: SKSpriteNode!
    
    var backButton = ButtonNode(normalImageNamed: "Back", activeImageNamed: "Back", disabledImageNamed: "Back")

    
    func setController(controller : GameProtocol) {
        self.controller = controller
    }
    
    func onSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Left:
            holder.texture = textureToPresent(1)
            print("Move Left")
        case UISwipeGestureRecognizerDirection.Right:
            holder.texture = textureToPresent(-1)
            print("Move Right")
        default:
            print("Invalid Move")
        }
    }
    
    func textureToPresent(inc: Int) -> SKTexture? {
        nextSlide += inc
        if nextSlide < textures.count && nextSlide > -1 {
            return textures[nextSlide]
        }
        else if nextSlide >= textures.count {
            nextSlide = textures.count - 1
            return textures[nextSlide]
        } else {
            nextSlide = 0
            return textures[nextSlide]
        }
    }

    
    override func didMoveToView(view: SKView) {
        for i in 1...4 {
            textures.append(SKTexture(imageNamed: "Jungle\(i)"))
        }
        
        holder = SKSpriteNode(texture: textures[0])
        addChild(holder)
        holder.position.x = scene!.size.width/2
        holder.position.y = scene!.size.height/2
        holder.zPosition = 0
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(GameSceneCamera.onSwipe(_:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneCamera.onSwipe(_:)))
        
        swipeLeft.direction = .Left
        swipeRight.direction = .Right
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        
        addChild(backButton)
        backButton.zPosition = 1
        backButton.position.x = scene!.size.width - (scene!.size.width/8) * 7
        backButton.position.y = scene!.size.height - (scene!.size.height/8) * 7
        backButton.setScale(0.9)
        backButton.selectedHandler = {
            self.controller.openingScene()
        }
        
        
        
        
        

        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}
