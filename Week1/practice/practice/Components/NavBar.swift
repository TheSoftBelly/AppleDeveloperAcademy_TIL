//  NavBar.swift
//  practice
//
//  Created by Joon on 3/12/26.

import SwiftUI

// 바텀바는 네비게이션보다는 탭뷰를 통해서 만드는게 수월하다
// NavigationStack은 각 탭 내부 View에서 필요할 때 따로 추가하는게 맞다
// TabView는 컴포넌트로 분리하는 게 아니라 최상위 앱 진입점에서 써야한다

struct NavBar: View {
    @State private var selectedTab = 2 // 현재 탭 추적 Home이 기본값 (index 2)
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Results view")
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Results")
                }
                .tag(0)
            
            Text("Racing view")
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Racing")
                }
                .tag(1)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
            
            Text("Standings view")
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Standings")
                }
                .tag(3)
            
            Text("More view")
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(4)
        }

        .accentColor(.red) // 선택된 탭 색상
    }
}

#Preview() {
    NavBar()
}
