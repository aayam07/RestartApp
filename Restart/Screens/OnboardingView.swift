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
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            
            Button {
                // some action to perform when the button is clicked
                isOnboardingViewActive = false
            } label: {
                Text("Start")
            }

            
        } //:VSTACk
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
