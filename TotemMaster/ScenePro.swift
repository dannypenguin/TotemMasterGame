//
//  ScenePro.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/2/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import Foundation
protocol Scene : class {
    func setController(controller : GameProtocol)
}