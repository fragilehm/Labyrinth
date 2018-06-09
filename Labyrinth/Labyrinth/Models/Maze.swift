//
//  Maze.swift
//  Labyrinth
//
//  Created by Khasanza on 6/7/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
import UIKit
class Maze {
    private var maze = [[Room]]()
    private var mazeSize = 3
    init() {
        generateMaze()
    }
    func getMaze() -> [[Room]] {
        return maze
    }
    private func generateMaze() {
        self.mazeSize = 3
            //Int(arc4random_uniform(7)) + 5
        initializeRooms()
        createPathToExit()
        addAdditionalDoors()
        let numberOfThings = 8
            //Int(arc4random_uniform(UInt32(self.mazeSize * self.mazeSize - 1)))
        generateEnemies(count: numberOfThings)
        generatePotions(count: numberOfThings)
        generateSwords(count: numberOfThings)
        generateCoins(count: numberOfThings)
    }
    private func initializeRooms() {
        //var maze = [[Room]]()
        for row in 0..<self.mazeSize {
            var mazeTemp = [Room]()
            for col in 0..<self.mazeSize {
                let room = Room()
                room.row = row
                room.col = col
                mazeTemp.append(room)
            }
            maze.append(mazeTemp)
        }
    }
    private func createPathToExit() {
        var row = 0
        var col = 0
        while true {
            let randDirection = Int(arc4random_uniform(2))
            var direction: Direction = Direction.init(rawValue: randDirection)!
            if row == mazeSize - 1 {
                direction = .east
            }
            if col == mazeSize - 1 {
                direction = .south
            }
            if direction == .south {
                maze[row][col].south = true
                maze[row + 1][col].north = true
                row += 1
            } else if direction == .east {
                maze[row][col].east = true
                maze[row][col + 1].west = true
                col += 1
            }
            if row == mazeSize - 1 && col == mazeSize - 1 {
                maze[row][col].south = true
                break
            }
        }
        maze[mazeSize - 1][mazeSize - 1].isExit = true
    }
    private func addAdditionalDoors() {
        for i in 0..<mazeSize {
            for j in 0..<mazeSize {
                let availableDirections = getAvailableDirections(row: i, col: j, room: maze[i][j])
                print(availableDirections.count)
                if availableDirections.count > 0 {
                    
                    let randDirection = Int(arc4random_uniform(UInt32(availableDirections.count)))
                    switch availableDirections[randDirection] {
                    case .south:
                        maze[i][j].south = true
                        maze[i + 1][j].north = true
                    case .east:
                        maze[i][j].east = true
                        maze[i][j + 1].west = true
                    case .north:
                        maze[i][j].north = true
                        maze[i - 1][j].south = true
                    case .west:
                        maze[i][j].west = true
                        maze[i][j - 1].east = true
                    }
                }
            }
        }
    }
    private func generateEnemies(count: Int) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            let randNumber = Int(arc4random_uniform(UInt32(mazeSize * mazeSize)))
            if randNumber != 0 {
                uniqueRoomNumber.insert(randNumber)
            }
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].enemy = true
        }
    }
    private func generatePotions(count: Int) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            uniqueRoomNumber.insert(Int(arc4random_uniform(UInt32(mazeSize * mazeSize))))
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].potion.append(20)
        }
    }
    private func generateSwords(count: Int) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            uniqueRoomNumber.insert(Int(arc4random_uniform(UInt32(mazeSize * mazeSize))))
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].sword = true
        }
    }
    private func generateCoins(count: Int) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            uniqueRoomNumber.insert(Int(arc4random_uniform(UInt32(mazeSize * mazeSize))))
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].coins = Int(arc4random_uniform(UInt32(100)) + 1)
        }
    }
    private func getAvailableDirections(row: Int, col: Int, room: Room) -> [Direction] {
        var availableDoors = [Direction]()
        if row == 0 && !room.south {
            availableDoors.append(.south)
        }
        if row == mazeSize - 1 && !room.north {
            availableDoors.append(.north)
        }
        if col == 0 && !room.east {
            availableDoors.append(.east)
        }
        if col == mazeSize - 1 && !room.west {
            availableDoors.append(.west)
        }
        if row > 0 && row < mazeSize - 1 {
            if !room.north {
                availableDoors.append(.north)
            }
            if !room.south {
                availableDoors.append(.south)
            }
        }
        if col > 0 && col < mazeSize - 1 {
            if !room.east {
                availableDoors.append(.east)
            }
            if !room.west {
                availableDoors.append(.west)
            }
        }
        return availableDoors
    }
}
