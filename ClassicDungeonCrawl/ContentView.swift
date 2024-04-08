//
//  ContentView.swift
//  IsoTutorial
//
//  Created by Maarten Engels on 27/01/2024.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    let scene = GameScene()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
            VStack {
                if  viewModel.selectedEntity != nil {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let topSafeAreaInset = windowScene.windows.first?.safeAreaInsets.top {
                        EntityView(viewModel: viewModel)
                            .padding(.top, topSafeAreaInset)
                    } else {
                        EntityView(viewModel: viewModel)
                    }
                }
                if let currentAction = viewModel.currentAction {
                    Button("Execute currentAction") {
                        print("Execute \(currentAction)")
                        viewModel.commitAction()
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                Spacer()
                if let selectedTile = viewModel.selectedTile {
                    let cordinate = "(\(selectedTile.x), \(selectedTile.y), \(selectedTile.z))"
                    Text("Selected tile: \(cordinate)")
                        .foregroundStyle(.white)
                }
                if let selectedEntity = viewModel.selectedEntity {
                    Text(selectedEntity.name)
                        .foregroundStyle(.white)
                }
                
                BottomActions(
                    rotateCCWAction: { scene.rotateCCW() },
                    setCameraScaleAction: { scene.setCameraScale() },
                    rotateCWAction: { scene.rotateCW() }
                ).padding(.bottom, 16)
            }
            .padding()
        }
        .ignoresSafeArea()
        .onAppear {
            scene.viewModel = viewModel
        }
        
    }
}

#Preview {
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
    
    let vm = ViewModel(map: Map(heightMap: heightMap), entities: entities)
    
    return ContentView(viewModel: vm)
}
