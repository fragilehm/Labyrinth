//
//  Room.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
class Room: Equatable {
    
    var north: Bool = false
    var east: Bool = false
    var west: Bool = false
    var south: Bool = false
    var enemy: Bool = false
    var sword: Bool = false
    var potion = [Int]()
    var isExit: Bool = false
    var coins = 0
    var row = 0
    var col = 0
    public static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}
