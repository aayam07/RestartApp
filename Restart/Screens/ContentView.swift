//
//  ContentView.swift
//  Restart
//
//  Created by Aayam Adhikari on 25/07/2023.
//

import SwiftUI

struct ContentView: View {
    
//    add a custom key on the app storate to identify active views. here "onboarding" is the key to identify the variable on the permanent app storage.
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
