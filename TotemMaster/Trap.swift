//
//  Trap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import Foundation

enum Trapstate {
    case Active, Change, Death, Benign
}

var deathDealer: Int = 0

protocol Trap {
//    func setTrapState() -> Trapstate
//    func damage() -> Int;
//    func hide()
}