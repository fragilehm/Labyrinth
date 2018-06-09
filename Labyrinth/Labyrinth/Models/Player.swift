//
//  Player.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation

class BackPack {
    fileprivate var capacity = 100
    fileprivate var sword: Bool = false
    fileprivate var potions = [20, 20, 20]
    func getSword() -> Bool {
        return sword
    }
    func getPotions() -> [Int] {
        return potions
    }
}
class Player {
    private var health: Int = 100
    private var backpack = BackPack()
    private var currentRoom: Room?
    private var name = ""
    private var coins: Int = 0
    private var pathDirections = [Direction]()
    func getCoins() -> Int {
        return coins
    }
    func getPathDirections() -> [Direction] {
        return pathDirections
    }
    func setCoins(coins: Int) {
        self.coins = coins
    }
    func getHealth() -> Int {
        return health
    }
    func getCurrentRoom() -> Room? {
        return currentRoom
    }
    func setCurrentRoom(room: Room) {
        self.currentRoom = room
    }
    func getBackpack() -> BackPack {
        return backpack
    }
    func getName() -> String {
        return name
    }
    func setName(name: String) {
        self.name = name
    }
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
                if let currentRoom = currentRoom, currentRoom.potion.count > 0 {
                    currentRoom.potion.removeLast()
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
            self.currentRoom?.potion.append(20)
        case .sword:
            if !self.backpack.sword {
                return false
            }
            self.backpack.sword = false
            self.currentRoom?.sword = true
        }
        return true

    }
    func addCoins(amount: Int) {
        self.coins += amount
        if let currentRoom = currentRoom {
            currentRoom.coins = 0
        }
    }
    func moveToRoomIfNotExit(room: Room, direction: Direction) {
        self.currentRoom = room
        self.pathDirections.append(direction)
        
    }
    func attackEnemy() {
        if self.backpack.sword {
            self.health = max(health - 10, 0)
        } else {
            self.health = max(health - 20, 0)
        }
    }
    func isCurrentRoomAnExit() -> Bool {
        if let currentRoom = currentRoom, currentRoom.isExit == true {
            self.pathDirections.append(.south)
            return true
        }
        return false
    }
    
    
}
