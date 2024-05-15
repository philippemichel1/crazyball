//
//  RenderingView.swift
//  crazyballs
//
//  Created by Philippe MICHEL on 11/05/2024.
//

import SwiftUI

struct RenderingView: View {
    @Binding var valuePositionX:Int  
    @Binding var valuePositionY:Int
    @Binding var newPosition:CGPoint
    
    @State private var position = CGPoint(x: 54, y: 80) // Position initiale de la boule
    let listColor:[Color] = [.green, .blue, .red, .yellow, .cyan, .orange, .indigo,.mint,.brown, .pink,.purple,.gray,.black]
    @State private var colorBall: Int = 0
    // déplacement vers la droite
    @Binding  var movingRight:Bool //= true
    // déplacement vers le bas
    @Binding  var movingDown:Bool// = true
    
    var body: some View {
        GeometryReader { geometry in
            Color(.white)
            Circle()
                .fill(listColor[colorBall])
                .frame(width: 50, height: 50)
                .position(x: position.x, y: position.y)
                .onAppear {
                    // Initialisation de colorBall avec un index de couleur aléatoire au démarrage.
                    colorBall = colorRandom()
                    // nouvelle position de départ
                    position = newPosition
                    // Calcul des limites maximales et minimales pour le mouvement de la boule, en prenant en compte sa taille.
                    let maxX = geometry.size.width - 25
                    let maxY = geometry.size.height - 25
                    let minX: CGFloat = 25
                    let minY: CGFloat = 25
                    
                    // definit la répetition et la vitesse de la boule
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    // appelle la fonction toutes les 0.01 pour mettre à jour la position de la boule.
                        newPosition(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // changement de couleur par nombre aléatoire
    func colorRandom() -> Int {
        return Int.random(in: 0...listColor.count - 1)
    }
    
    // nouvelle position de la boule
    func newPosition(minX:CGFloat, minY:CGFloat, maxX:CGFloat, maxY:CGFloat) {
        // Déterminer la nouvelle position en X
        if movingRight {
            if position.x >= maxX {
                movingRight = false
                colorBall = colorRandom()
            } else {
                
                position.x += CGFloat(valuePositionX)
            }
        } else {
            if position.x <= minX {
                movingRight = true
                colorBall = colorRandom()
            } else {
                position.x -= CGFloat(valuePositionX)
            }
        }
        
        // Déterminer la nouvelle position en Y
        if movingDown {
            if position.y >= maxY {
                movingDown = false
                colorBall = colorRandom()
            } else {
                position.y += CGFloat(valuePositionY)
            }
        } else {
            if position.y <= minY {
                movingDown = true
                colorBall = colorRandom()
            } else {
                position.y -= CGFloat(valuePositionY)
            }
        }
    }
}



#Preview {
    RenderingView(valuePositionX: .constant(0), valuePositionY: .constant(0), newPosition: .constant(CGPoint(x: 54, y: 80)),movingRight: .constant(true),movingDown: .constant(true))
}
