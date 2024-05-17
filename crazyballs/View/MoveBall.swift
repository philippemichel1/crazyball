//
//  MoveBall.swift
//  crazyballs
//
//  Created by Philippe MICHEL on 13/05/2024.

import SwiftUI
struct MoveBall: View {
    @Environment(\.dismiss) var dismiss
    // Position initiale
    @State private var position = CGPoint(x: 54, y: 80)
    // garder position (Toggle)
    @Binding var keepPosition:Bool
    var settingP:SettingP
    
    var body: some View {
        GeometryReader { geometry in
                Color(.gray).opacity(0.25)
                        VStack {
                            Spacer()
                            Text("Déplacer le cercle,avec votre doigt, pour modifier sa position départ.")
                                .multilineTextAlignment(.leading)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal)
                            Spacer()
                            Button {
                                settingP.position = self.position
                                dismiss()
                            } label: {
                                Text("Valider")
                            }
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                        }
                        .overlay {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .position(position)
                                .gesture(
                                    DragGesture()
                                       .onChanged { gesture in
                                           self.position = gesture.location
                                      }
                                        .onEnded({ gesture in
                                            self.position = gesture.location
                                            keepPosition = true
                                        })
                                )
                        }
            }
            .onAppear {
                if keepPosition == true {
                    self.position = settingP.position
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MoveBall(keepPosition: .constant(false), settingP: SettingP())
}
