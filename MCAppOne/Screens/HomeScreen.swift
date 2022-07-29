//
//  HomeScreen.swift
//  MCAppOne
//
//  Created by Mohan Chaudhari on 28/07/22.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false

    var body: some View {
        ZStack {
            
            VStack(spacing: 40) {
                Text("Hello, Home Screen!")
                    .font(.largeTitle)
                Button(action: {
                    isOnboardingViewActive = true
                }) {
                    Text("Start")
                }
            }
        }        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
