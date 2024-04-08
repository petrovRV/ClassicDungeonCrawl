//
//  CreatureFactory.swift
//  ClassicDungeonCrawl
//
//  Created by Yurii Petrov on 07.04.2024.
//

enum MonsterName: String {
    case skeletonM = "Skeleton m"
    case skeletonR = "Skeleton r"
}

protocol CreatureFactory {
    func createPlayer(name: String, role: Role, appearance: CreatureAppearance) -> Player
    func createSkeleton(role: Role, appearance: CreatureAppearance) -> Monster
}

struct CreatureFactoryImpl: CreatureFactory {
    func createPlayer(name: String, role: Role, appearance: CreatureAppearance) -> Player {
        switch role {
        case .melee:
            createMelee(name: name, appearance: appearance)
        case .range:
            createRange(name: name, appearance: appearance)
        }
    }
    
    private func createMelee(name: String, appearance: CreatureAppearance) -> Player {
        Player(name: name, hp: 10, move: 2, role: .melee, appearance: appearance)
    }
    
    private func createRange(name: String, appearance: CreatureAppearance) -> Player {
        Player(name: name, hp: 7, move: 3, role: .range, appearance: appearance)
    }
    
    func createSkeleton(role: Role, appearance: CreatureAppearance) -> Monster {
        switch role {
        case .melee:
            createSkeletonMelee(appearance: appearance)
        case .range:
            createSkeletonRange(appearance: appearance)
        }
    }
    
    private func createSkeletonMelee(appearance: CreatureAppearance) -> Monster {
        Monster(name: MonsterName.skeletonM.rawValue, hp: 5, move: 1, appearance: appearance)
    }
    
    private func createSkeletonRange(appearance: CreatureAppearance) -> Monster {
        Monster(name: MonsterName.skeletonM.rawValue, hp: 3, move: 2, appearance: appearance)
    }
}

