//
//  RenderingView.swift
//  crazyballs
//
//  Created by Philippe MICHEL on 11/05/2024.
//

import SwiftUI

struct RenderingView: View {
    @State private var position = CGPoint(x: 54, y: 80)// Position initiale de la boule
    let listColor:[Color] = [.green, .blue, .red, .yellow, .cyan, .orange, .indigo,.mint,.brown, .pink,.purple,.gray,.black]
    @State private var colorBall: Int = 0
    // déplacement vers la droite
    @Binding  var movingRight:Bool //= true
    // déplacement vers le bas
    @Binding var movingDown:Bool// = true
    // definit par stepper valeur Y
    @Binding var valuePositionX:Int
    // definit par stepper valeur X
    @Binding var valuePositionY:Int
    // passe la nouvelle position de la boule si l'utilisateur l'déplacé
    @Binding var newPosition:CGPoint
    
    @Binding var isKeepPosition:Bool
    
    // déclare une variable de type timer pour pouvoir arreter l'animation
    @State private var timer:Timer?
    
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
                    if isKeepPosition == true {
                        position = newPosition
                    }  else {
                        position = CGPoint(x: 54, y: 80)
                    }
                    //print(position)
                    // Calcul des limites maximales et minimales pour le mouvement de la boule, en prenant en compte sa taille.
                    let maxX = geometry.size.width - 25
                    let maxY = geometry.size.height - 25
                    let minX: CGFloat = 25
                    let minY: CGFloat = 25
                    
                    // definit la répetition et la vitesse de la boule
                    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                        // appelle la fonction toutes les 0.01 pour mettre à jour la position de la boule.
                        newPosition(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
                    }
                }.onDisappear{
                    // arrete le timer lorsque l'on quitte la vue
                    timer?.invalidate()
                    timer = nil
                    // parametre par défaut en sortant de la vue sauf la
                    // position de la ball
                    movingDown = true
                    movingRight = true
                    valuePositionX = 4
                    valuePositionY = 4
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
    RenderingView(movingRight: .constant(true), movingDown: .constant(true), valuePositionX: .constant(0), valuePositionY: .constant(0), newPosition: .constant(CGPoint(x: 54, y: 80)), isKeepPosition: .constant(false))
}
