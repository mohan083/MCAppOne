//
//  OnBoarding.swift
//  MCAppOne
//
//  Created by Mohan Chaudhari on 28/07/22.
//

import SwiftUI

struct OnBoarding: View {

    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonOffset: CGFloat = 0
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var textTitle: String = "Share."

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            // MARK: - Header

            VStack(spacing: 20) {
                Spacer()
                VStack (spacing: 0){

                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)

                    Text("""
                    Some Long Text here for
                    new line example
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)

                // MARK: - Center
                ZStack {
                    CircleAnimation(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1, y: 0)
                        .blur(radius: abs(imageOffset.width / 8))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        textTitle = "Give."
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    textTitle = "Share."
                                })
                        )
                        .animation(.easeOut(duration: 0.6), value: imageOffset)
                }

                Spacer()

                // MARK: - Footer

                ZStack {
                    // MARK: - 1. Backround
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    // MARK: - 2. Call to Action
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // MARK: - 3. Capsule Dynamic

                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }

                    // MARK: - 4 : Circle Draggable

                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))

                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x: buttonOffset - 110)
                    .gesture(
                        DragGesture().onChanged({ gesture in
                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                buttonOffset = gesture.translation.width
                            }
                        })
                            .onEnded({ guesture in
                                withAnimation(Animation.easeOut(duration: 0.5)) {

                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                }
                            })
                    )
                    Spacer()
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
