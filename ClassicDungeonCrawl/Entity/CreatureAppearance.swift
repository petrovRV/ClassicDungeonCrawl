//
//  CreatureAppearance.swift
//  ClassicDungeonCrawl
//
//  Created by Yurii Petrov on 07/04/2024.
//

struct CreatureAppearance {
    let sprite: String
    var position: Vector3D
    var rotation = Rotation.defaultRotation
    var currentAction: Action?
    
    init(sprite: String, startPosition: Vector3D, rotation: Rotation = .defaultRotation) {
        self.sprite = sprite
        self.position = startPosition
        self.rotation = rotation
    }
    
    mutating func completeCurrentAction() {
        currentAction?.complete()
        currentAction = nil
    }
}
