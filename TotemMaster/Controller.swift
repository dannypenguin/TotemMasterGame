//
//  Controller.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/2/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import Foundation

protocol Controller : class {
    func startGame()
    func gameOver()
    func openingScene()
    func tutorialScene()
    func gameLimbo()
}
