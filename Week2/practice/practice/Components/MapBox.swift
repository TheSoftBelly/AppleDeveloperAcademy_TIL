//
//  MapBox.swift
//  practice
//
//  Created by Joon on 3/12/26.
//
import SwiftUI

struct MapBox: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.mapBackground)
                .cornerRadius(20)
                
            Image("Map")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(10)
        }
    }
}

#Preview {
    MapBox()
}
