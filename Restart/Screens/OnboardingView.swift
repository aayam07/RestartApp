//
//  OnboardingView.swift
//  Restart
//
//  Created by Aayam Adhikari on 25/07/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - PROPERTY
//    To access the previously stored onboarding key value in this file, we have redeclared it the same
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    // Two properties to create drag gesture on the slidable button
    
    // establish constraint to the button's horizontal movement. 40+40 = 80 paddings to the leading and trailing
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80  // capsule button width
    
    // property to represent offset value in the horizontal direction
    @State private var buttonOffset: CGFloat = 0
    
    // a property to control the animation of the objects. true value indicates that the animation has started
    @State private var isAnimating: Bool = false
    
    
    // to implement horizontal drag gesture to the illustration image
    @State private var imageOffset: CGSize = .zero
    
    // to control the opacity of arrow indicator symbol during the drag of the image
    @State private var indicatorOpacity: Double = 1.0
    
    // to change the text title dynamically when the character image is dragged
    @State private var textTitle: String = "Share."
    
    // to create a new property that will conform to the HAPTIC feedback generator prototype
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                //MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)  // to apply smooth transition to view
                        .id(textTitle)  // to tell the SwiftUI that when the textTitle value is changed, this text view is entirely a different view by providing a new id to the view so that it reconstructs it and applies the opacity transition
                    
                    // Multiline texts using """
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - CENTER
                
                ZStack {
                    
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)  // to move to opposite direction multiply by -1
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))  // rotate by dynamic value
                        .gesture(
                          DragGesture()
                            .onChanged({ gesture in
                                if abs(imageOffset.width) <= 150 {
                                    imageOffset = gesture.translation  // provides necessary information about the total movement from the start of the drag gesture to the current event of the drag gesture
                                    
                                    // to hide the arrow symbol when the image is dragged
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    }
                                }
                            })
                            .onEnded({ _ in
//                                withAnimation {
//                                    imageOffset = .zero
//                                }
                                imageOffset = .zero
                                
                                // to make the arrow symbol visible when the image is back to the center, after the dragging has stop
                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            })
                        )  //: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    
                } //: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                //MARK: - FOOTER
                
                // custom draggable button
                ZStack {
                    //PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x: 10)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH/DEFORMABLE SHAPE)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)  // to make the back capsue deform its shape by the width of the draggable circle
                      
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    
                                    // run only when the dragging has been started in the right direction and prevent from going out of the button view
                                    if gesture.translation.width > 0 && buttonOffset <= (buttonWidth - 80) {
                                        
                                        buttonOffset = gesture.translation.width  // capturing actual drag movement width for later use
                                    }
                                })
                                .onEnded({ _ in
                                    DispatchQueue.main.async {
                                        // to provide animation when switching between screens
                                        withAnimation(Animation.easeOut(duration: 0.4)) {
                                            if buttonOffset > (buttonWidth / 2) {
                                                
                                                // to create a success type haptic feedback
                                                hapticFeedback.notificationOccurred(.success)
                                                
                                                // to play sound sound while swipping to the home screen
                                                playSound(sound: "chimeup", type: "mp3")
                                                
                                                buttonOffset = buttonWidth - 80
                                                isOnboardingViewActive = false  // switch to home screen
                                            } else {
                                                
                                                hapticFeedback.notificationOccurred(.warning)
                                                buttonOffset = 0
                                                
                                            }
                                        }
                                    }
                                    
                                })
                        )  //: GESTURE
                        
                        Spacer()  // push draggable circle to the left
                        
                    }
                    
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
          
            } //: VSTACK
        }  //: ZSTACK
        .onAppear {
            isAnimating = true
        }
//        .preferredColorScheme(.dark)  // to apply dark mode to the onboarding view in all cases
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
