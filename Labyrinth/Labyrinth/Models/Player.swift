//
//  Player.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation

class BackPack {
    var capacity = 100
    var sword: Bool = false
    var potions = [20, 20, 20]
    
}
class Player {
    var health: Int = 100
    var backpack = BackPack()
    var currentRoom: Room?
    var name = ""
    var coins: Int = 0
    var pathDirections = [Direction]()

    func useThingIfThereIsOne(thingName: ThingName) -> Bool {
        switch thingName {
        case .potion:
            if self.backpack.potions.count == 0 {
                return false
            }
            self.backpack.capacity += thingName.rawValue
            self.backpack.potions.removeLast()
            self.health = min(self.health + 20, 100)
        case .sword:
            if !self.backpack.sword {
                return false
            }
            self.health -= 20
        }
        return true
    }
    func takeThingIfEnoughSpace(thingName: ThingName) -> Bool {
        if backpack.capacity - thingName.rawValue >= 0 {
            self.backpack.capacity -= thingName.rawValue
            switch thingName {
            case .potion:
                if let currentRoom = currentRoom {
                    currentRoom.potion = false
                }
                self.backpack.potions.append(20)
            case .sword:
                if let currentRoom = currentRoom {
                    currentRoom.sword = false
                }
                self.backpack.sword = true
            }
            return true
        } else {
            return false
        }
    }
    func dropThingIfNotEmpty(thingName: ThingName) -> Bool {
        self.backpack.capacity += self.backpack.capacity == 150 ? 0 : thingName.rawValue
        switch thingName {
        case .potion:
            if self.backpack.potions.count == 0 {
                return false
            }
            self.backpack.potions.removeLast()
        case .sword:
            if !self.backpack.sword {
                return false
            }
            self.backpack.sword = false
        }
        return true

    }
    func addCoins(amount: Int) {
        self.coins += amount
        if let currentRoom = currentRoom {
            currentRoom.coins = 0
        }
    }
    func moveToRoomIfNotExit(room: Room) {
        self.currentRoom = room
    }
    func attackEnemy() {
        if self.backpack.sword {
            self.health = max(health - 10, 0)
        } else {
            self.health = max(health - 20, 0)
        }
    }
    
    
}
