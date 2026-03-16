//
//  FeaturePage.swift
//  OnboardingFlow
//
//  Created by Joon on 3/17/26.
//

import SwiftUI

struct FeaturePage: View {
    var body: some View {
        VStack{
            Text("Feature Page")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill", description: "A multiline description about a feature paired with an icon")
            FeatureCard(iconName: "quote.bubble.fill", description: "Short description about a feature")
        }
        .padding()
    }
}

#Preview {
    FeaturePage()
}
