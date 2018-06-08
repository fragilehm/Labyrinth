//
//  Room.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
class Room {
    var north: Bool = false
    var east: Bool = false
    var west: Bool = false
    var south: Bool = false
    var enemy: Bool = false
    var sword: Bool = false
    var potion: Bool = false
    var isExit: Bool = false
    var coins = 0
}
