//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by Joon on 3/17/26.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius:30)
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color.blue)
                
                Image(systemName:"figure.2.and.child.holdinghands")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
            }
            Text("Welcome to My App")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("Description text")
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
    WelcomePage()
}
