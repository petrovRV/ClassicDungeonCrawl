//
//  Creature.swift
//  ClassicDungeonCrawl
//
//  Created by Yurii Petrov on 07.04.2024.
//

protocol Creature {
    var name: String { get set }
    var hp: Int { get set }
    var move: Int { get }
    var appearance: CreatureAppearance { get set }
}

struct Monster: Creature {
    var name: String
    var hp: Int
    var move: Int
    var appearance: CreatureAppearance
}

enum Role {
    case melee
    case range
}

struct Player: Creature {
    var name: String
    var hp: Int
    var move: Int
    var role: Role
    var appearance: CreatureAppearance
}
