//
//  HomeView.swift
//  Restart
//
//  Created by Aayam Adhikari on 25/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - PROPERTY
    
    // We are not setting the variable value here as false, it is just for safety reasons in case the program doesn't find the onboarding key in its permanent storage
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            
            Button {
                //some action to perform when user taps on the button
                isOnboardingViewActive = true
                
            } label: {
                Text("Restart")
            }

            
        } //: VSTACK
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
