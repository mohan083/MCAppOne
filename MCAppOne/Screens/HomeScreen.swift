//
//  HomeScreen.swift
//  MCAppOne
//
//  Created by Mohan Chaudhari on 28/07/22.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false

    var body: some View {
        VStack (alignment: .center, spacing: 40){

            Spacer()

            ZStack {
                CircleAnimation(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation
                                .easeIn(duration: 4)
                                .repeatForever(), value: isAnimating)
            }

            Text("""
                    Some long string with next line character will be here!!
                """)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .padding()

            Button(action: {
                isOnboardingViewActive = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isAnimating = true
            })
        })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
