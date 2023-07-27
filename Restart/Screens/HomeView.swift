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
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            
            //MARK: - HEADER
            Spacer()
            
            ZStack {
                
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.2)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            }
            
            
            //MARK: - Center
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - FOOTER
            
            Spacer()
            
            // Button (Or other UI components or views) uses Accent Color defined in the Assets folder, if not defined then uses the default color specified by Apple.
            
            Button {
                //some action
                isOnboardingViewActive = true
            } label: {
                
                // no need to use HSTACK in button label as SwiftUI automatically renders two or more components as HSTACK in Button's Label
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
          
            }  //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





// initial try
//VStack {
//    Spacer()
//
//    // HEADER
//    ZStack {
//        ZStack {
//            Circle()
//                .stroke(.gray.opacity(0.2), lineWidth: 40)
//                .frame(width: 260, height: 260, alignment: .center)
//
//            Circle()
//                .stroke(.gray.opacity(0.2), lineWidth: 80)
//                .frame(width: 260, height: 260, alignment: .center)
//
//
//        }  //: ZSTACK
//
//        Image("character-2")
//            .resizable()
//            .scaledToFit()
//    } //: ZSTACK
//
//    Spacer()
//
//    Text("""
//    The time that leads to mastery is
//    dependent on the intensity of our focus.
//    """)
//    .font(.title3)
//    .fontWeight(.light)
//    .foregroundColor(.gray)
//    .multilineTextAlignment(.center)
//    .padding(.vertical, -70)
//
//    Spacer()
//
//    Button {
//        // some action
//    } label: {
//        Text("Hello")
//    }
//
//}  //: VSTACK
