//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by Joon on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    let gradientColors: [Color] = [.grdientTop,.gradientBottom]
    var body: some View {
       TabView {
           WelcomePage()
           
           FeaturePage()
        }
       .background(Gradient(colors: gradientColors))
       .tabViewStyle(.page)
    }
}

#Preview {
    ContentView()
}
