//
//  Player.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation

class BackPack {
    var capacity = 150
    var sword: Bool = false
    var potions = [Int]()
    func getThings() -> [String: Any] {
        return ["sword": sword, "potions": potions]
    }
}
class Player {
    var health: Int = 100
    var backpack: BackPack!
    var currentRoom: Room?
    func getThings() -> [String: Any] {
        return backpack.getThings()
    }
    func useThing(thingName: ThingName) {
        self.backpack.capacity += thingName.rawValue
        switch thingName {
        case .potion:
            self.health = min(self.health + 20 * self.backpack.potions.count, 100)
        case .sword:
            self.health -= 20
        }
    }
    func takeThingIfEnoughSpace(thingName: ThingName) -> Bool {
        if backpack.capacity - thingName.rawValue >= 0 {
            self.backpack.capacity -= thingName.rawValue
            switch thingName {
            case .potion:
                self.backpack.potions.append(20)
            case .sword:
                self.backpack.sword = true
            }
            return true
        } else {
            return false
        }
    }
    func dropThingIfNotEmpty(thingName: ThingName) -> Bool {
        if backpack.capacity == 150 {
            return false
        } else {
            switch thingName {
            case .potion:
                self.backpack.potions.removeLast()
            case .sword:
                self.backpack.sword = false
            }
            return true
        }
        
    }
    func moveToRoomIfNotExit(room: Room) -> Bool {
        self.currentRoom = room
        if room.isExit {
            return true
        }
        return false
    }
    func attackEnemy() -> Int {
        if self.backpack.sword {
            self.health -= 20
        } else {
            self.health -= 50
        }
        return health
    }
    
    
}
