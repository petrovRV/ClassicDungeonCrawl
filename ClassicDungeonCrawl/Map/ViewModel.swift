//
//  ViewModel.swift
//  IsoTutorial
//
//  Created by Maarten Engels on 01/04/2024.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var selectedTile: Vector3D?
    @Published var selectedEntity: Creature?
    @Published var currentAction: Action?
    
    let map: Map
    var entities: [Creature]
    var redraw: (() -> Void)?
    
    init(map: Map, entities: [Creature]) {
        self.map = map
        self.entities = entities
    }
    
    func clickTile(_ tile: Vector3D) {
        selectedTile = nil
        
        
        if map.tiles.keys.contains(tile.xy) {
            selectedTile = tile
        }
        
        if let currentAction = currentAction {
            if let selectedTile, let selectedEntity {
                let action = type(of: currentAction)
                    .make(in: map, for: selectedEntity.appearance, targetting: selectedTile)
                self.currentAction = action
            }
        } else {
            selectedEntity = nil
            if let entity = entities.first(where: { $0.appearance.position == tile }) {
                selectedEntity = entity
            }
        }
    }
    
    func commitAction() {
        selectedEntity?.appearance.currentAction = currentAction
        currentAction = nil
        redraw?()
    }
}
