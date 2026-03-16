//
//  ContentView.swift
//  Tutorial
//
//  Created by Joon on 3/17/26.
//  이 작업은 애플의 공식문서를 따라서 이루어진다는 것을 알림

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            DateInfo(days: "Mon",isRainy: true , high: 80, low: 30)
            
            DateInfo(days: "Tue",isRainy: false, high: 30, low: 20)
        }
    }
}

struct DateInfo:View {
    let days: String
    let isRainy: Bool
    let high: Int
    let low: Int
    
    var iconName: String {
        isRainy ? "sun.max.fill" : "cloud.rain.fill"
    }
    var iconColor: Color {
        isRainy ? Color.yellow : Color.blue
    }
    
    var body: some View {
        VStack {
                    Text(days)
                        .font(Font.headline)
                    Image(systemName: iconName)
                        .foregroundStyle(iconColor)
                        .font(Font.largeTitle)
                        .padding(5)
                    Text("High: \(high)")
                        .fontWeight(Font.Weight.semibold)
                    Text("Low: \(low)")
                        .fontWeight(Font.Weight.medium)
                        .foregroundStyle(Color.secondary)
                }
        .padding(10)
    }
}

#Preview {
    ContentView()
}
