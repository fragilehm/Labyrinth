//
//  MainSceneViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
enum Direction: Int {
    case south = 0
    case east
    case north
    case west
}
class MainSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func generateMaze(_ sender: Any) {
        self.generateMaze()
    }
    private func generateMaze() {
        let mazeSize = 3
            //Int(arc4random_uniform(20)) + 3
        var maze = initializeRooms(mazeSize: mazeSize)
        createPathToExit(mazeSize: mazeSize, maze: maze)
        addAdditionalDoors(mazeSize: mazeSize, maze: maze)
        let numberOfThings = Int(arc4random_uniform(UInt32(mazeSize * mazeSize)))
        generateEnemies(mazeSize: mazeSize, count: numberOfThings, maze: maze)
        generatePotions(mazeSize: mazeSize, count: numberOfThings, maze: maze)
        generateSwords(mazeSize: mazeSize, count: numberOfThings, maze: maze)

        for i in 0..<mazeSize {
            for j in 0..<mazeSize {
                print("     ", maze[i][j].north)
                print(maze[i][j].west, "     ", maze[i][j].east)
                print("     ", maze[i][j].south)
                print("enemy ", maze[i][j].enemy)
                print("potion ", maze[i][j].potion)
                print("sword ", maze[i][j].sword)
            }
        }
    }
    private func initializeRooms(mazeSize: Int) -> [[Room]] {
        var maze = [[Room]]()
        for _ in 0..<mazeSize {
            var mazeTemp = [Room]()
            for _ in 0..<mazeSize {
                mazeTemp.append(Room())
            }
            maze.append(mazeTemp)
        }
        return maze
    }
    private func createPathToExit(mazeSize: Int, maze: [[Room]]) {
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
    }
    private func addAdditionalDoors(mazeSize: Int, maze: [[Room]]) {
        for i in 0..<mazeSize {
            for j in 0..<mazeSize {
                let availableDirections = getAvailableDirections(mazeSize: mazeSize, row: i, col: j, room: maze[i][j])
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
    private func generateEnemies(mazeSize: Int, count: Int, maze: [[Room]]) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            uniqueRoomNumber.insert(Int(arc4random_uniform(UInt32(mazeSize * mazeSize))))
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].enemy = true
        }
    }
    private func generatePotions(mazeSize: Int, count: Int, maze: [[Room]]) {
        var uniqueRoomNumber = Set<Int>()
        while uniqueRoomNumber.count < count {
            uniqueRoomNumber.insert(Int(arc4random_uniform(UInt32(mazeSize * mazeSize))))
        }
        print(uniqueRoomNumber.count)
        for roomNumber in uniqueRoomNumber {
            let col = roomNumber % mazeSize
            let row = (roomNumber - col) / mazeSize
            maze[row][col].potion = true
        }
    }
    private func generateSwords(mazeSize: Int, count: Int, maze: [[Room]]) {
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
    private func getAvailableDirections(mazeSize: Int, row: Int, col: Int, room: Room) -> [Direction] {
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
