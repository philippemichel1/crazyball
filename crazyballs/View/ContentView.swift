//
//  ContentView.swift
//  crazyballs
//
//  Created by Philippe MICHEL on 11/05/2024.
//
import SwiftUI

struct ContentView: View {
    // Position initiale
    @State private var position = CGPoint(x: 54, y: 80)
    // bouton du rendu animation
    @State var renderingButton:Bool = false
    // valeur changement de position horizontal de la boule
    @State var valuePositionX:Int = 4
    // valeur changement de position vertical de la boule
    @State var valuePositionY:Int = 4
    // affiche la fenetre de position de la boule
    @State var showViewSetBall:Bool = false
    // déplacement vers la droite
    @State private var movingRight = true
    // déplacement vers le bas
    @State private var movingDown = true
    //creation de l'object de recuperation de la position de la boule
    @State var settingP:SettingP = SettingP()
    
    var body: some View {
        NavigationStack {
            VStack{
                Image("titastus")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius:10).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }

            Spacer()
            Form {
                Section(header: Text("Horizontale")) {
                    Stepper("Position(x)  \(valuePositionX)", value: $valuePositionX, in: 0...10)
                } // fin de section
                
                Section(header: Text("Verticale")) {
                    Stepper("Position(y)  \(valuePositionY)", value: $valuePositionY, in: 0...10)
                } // fin de section
                
                Section(header:Text("Direction")) {
                    Toggle(movingRight ? "Vers la droite" : "vers la gauche", isOn: $movingRight)
                        .tint(.blue)
                    Toggle(movingDown ?"Vers le bas" : "Vers le haut", isOn: $movingDown)
                        .tint(.blue)
                } // Fin de section
                
                Section(header:Text("Position Ball")) {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showViewSetBall.toggle()
                        }, label: {
                            Text("Position de départ de la Boule")
                        })
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showViewSetBall) {
                            MoveBall(settingP: self.settingP)
                        }
                        Spacer()
                    }
                }
            }// form
            // affiche le formulaire résultat
            Button(action: {
                self.renderingButton.toggle()
            }, label: {
                Text("Lancer")
            })
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            .navigationDestination(isPresented: $renderingButton) {
                RenderingView(movingRight: $movingRight, movingDown: $movingDown, valuePositionX: $valuePositionX, valuePositionY: $valuePositionY, newPosition: .constant(CGPoint(x:settingP.position.x,y:settingP.position.y)))
            }
            .navigationTitle("Paramètrage")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
