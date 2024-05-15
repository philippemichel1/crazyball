//
//  ContentView.swift
//  crazyballs
//
//  Created by Philippe MICHEL on 11/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var position = CGPoint(x: 54, y: 31) // Position initiale
    @State var renderingButton:Bool = false
    @State var valuePositionX:Int = 5
    @State var valuePositionY:Int = 5
    @State var showViewSetBall:Bool = false
    // déplacement vers la droite 
    @State private var movingRight = true
    // déplacement vers le bas
    @State private var movingDown = true
    @State var settingP:SettingP = SettingP()
    
    
    
    var body: some View {
       // GeometryReader { geometry in
            NavigationStack {
                Spacer(minLength: 50)
                Form {
                    VStack (alignment: .leading) {
                        Section("Horizontal") {
                            Stepper("Position.x : \(valuePositionX)", value: $valuePositionX, in: 0...10)
                        }
                        VStack (alignment: .leading) {
                            Spacer(minLength: 10)
                            Section("Vertical") {
                                Stepper("Position.y : \(valuePositionY)", value: $valuePositionY, in: 0...10)
                            }
                        }
                        
                        Section("Direction") {
                            Toggle(movingRight ? "Droite" : "Gauche", isOn: $movingRight)
                                .tint(.blue)
                            Toggle(movingDown ?"Bas" : "Haut", isOn: $movingDown)
                                .tint(.blue)
                        }
                        
                    }
                    Section("Position") {
                        Button(action: {
                            self.showViewSetBall.toggle()
                        }, label: {
                            Text("Position de la Boule")
                        })
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showViewSetBall) {
                            MoveBall(settingP: self.settingP)
                        }
                    }
                   
                       
                    
                }
                
                Button(action: {
                    self.renderingButton.toggle()
                }, label: {
                    Text("voir le rendu")
                })
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                .navigationDestination(isPresented: $renderingButton) {
                    RenderingView(valuePositionX: $valuePositionX, valuePositionY: $valuePositionY, newPosition:.constant(CGPoint(x:settingP.position.x,y:settingP.position.y)),movingRight: $movingRight,movingDown: $movingDown)
                }
                Spacer(minLength: 50)
                .navigationTitle("Paramètrage")
            }
            .edgesIgnoringSafeArea(.all)
       // }
       
        
        
    }
}

#Preview {
    ContentView()
}
