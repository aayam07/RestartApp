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
    
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                //MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    // Multiline texts using """
                    Text("""
                    It's not how much we give but
                    much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                } //: HEADER
                
                //MARK: - CENTER
                
                ZStack {
                    
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    
                } //: CENTER
                
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
                                    
                                    if buttonOffset > (buttonWidth / 2) {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false  // switch to home screen
                                    } else {
                                        buttonOffset = 0
                                    }
                                    
                                })
                        )  //: GESTURE
                        
                        Spacer()  // push draggable circle to the left
                        
                    }
                    
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
          
            } //: VSTACK
        }  //: ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
