//
//  BottomActions.swift
//  ClassicDungeonCrawl
//
//  Created by Yurii Petrov on 07.04.2024.
//

import SwiftUI

struct BottomActions: View {
    let rotateCCWAction: () -> Void
    let setCameraScaleAction: () -> Void
    let rotateCWAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: rotateCCWAction) {
                Text("<")
                    .frame(width: 25, height: 15)
            }
            Spacer()
            Button(action: setCameraScaleAction) {
                Text("±")
                    .frame(width: 25, height: 15)
            }
            Spacer()
            Button(action: rotateCWAction) {
                Text(">")
                    .frame(width: 25, height: 15)
            }
        }
    }
}

#Preview {
    BottomActions(
        rotateCCWAction: { print("Rotate CCW") },
        setCameraScaleAction: { print("Set Camera Scale") },
        rotateCWAction: { print("Rotate CW") }
    )
}
