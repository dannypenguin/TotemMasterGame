//
//  GameProtocol.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/2/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

protocol GameProtocol: class {
    func startGame()
    func gameOver()
    func getScore() -> Int
    func incrementScore(bonus: Int) -> Int
    func setScoreGame(dec: Int) -> Int
    func setGameDistance(dis: CGFloat)
    
}