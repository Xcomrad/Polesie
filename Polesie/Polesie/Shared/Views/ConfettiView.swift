//
//  ConfettiView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import SwiftUI
import SpriteKit

struct ConfettiView: UIViewRepresentable {
    typealias UIViewType = SKView
    
    func makeUIView(context: Context) -> UIViewType {
        let view = SKView()
        view.allowsTransparency = true
        
        let scene = SKScene(size: UIScreen.main.bounds.size)
        scene.backgroundColor = .clear
        
        if let emitter = SKEmitterNode(fileNamed: "Confetti.sks") {
            emitter.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            emitter.zPosition = -1
            scene.addChild(emitter)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                emitter.particleBirthRate = 0
            }
        }
        
        view.presentScene(scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
}
