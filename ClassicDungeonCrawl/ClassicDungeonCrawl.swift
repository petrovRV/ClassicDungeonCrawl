//
//  ClassicDungeonCrawl.swift
//  ClassicDungeonCrawl
//
//  Created by Yurii Petrov on 06/04/2024.
//

import SwiftUI

@main
struct ClassicDungeonCrawl: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: createViewModel())
        }
    }
    
    func createViewModel() -> ViewModel {
        let heightMap: [[Int]] = .init(repeating: .init(repeating: 1, count: 6), count: 10)
        
        let cF = CreatureFactoryImpl()
        
        let playerPositions = [
            Vector3D(x: 3, y: 0, z: 1),
            Vector3D(x: 2, y: 0, z: 1)
        ]
        
        let skeletonMPositions = [
            Vector3D(x: 2, y: 3, z: 1),
            Vector3D(x: 3, y: 3, z: 1)
        ]
        
        let skeletonRPositions = [
            Vector3D(x: 0, y: 4, z: 1),
            Vector3D(x: 5, y: 4, z: 1)]
        
        var entities = [Creature]()
        for i in 0...1 {
            let position = playerPositions[i]
            let playerNumber = i+1
            let ca = CreatureAppearance(sprite: playerNumber == 1 ? "Knight" : "Rogue", startPosition: position, rotation: .degrees135)
            let p = cF.createPlayer(name: "Player \(playerNumber)", role: playerNumber == 1 ? .melee : .range, appearance: ca)
            entities.append(p)
        }
        
        for i in 0...1 {
            let position = skeletonMPositions[i]
            let ca = CreatureAppearance(sprite: "Knight", startPosition: position, rotation: .degrees315)
            let s = cF.createSkeleton(role: .melee, appearance: ca)
            entities.append(s)
        }
        
        for i in 0...1 {
            let position = skeletonRPositions[i]
            let ca = CreatureAppearance(sprite: "Rogue", startPosition: position, rotation: .degrees315)
            let s = cF.createSkeleton(role: .range, appearance: ca)
            entities.append(s)
        }
        
        return ViewModel(map: Map(heightMap: heightMap), entities: entities)
    }
}
