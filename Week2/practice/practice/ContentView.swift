import SwiftUI

struct ContentView: View {
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


// #Preview는 미리 보기에서 어떤 기기를 통해서 미리보기를 할지 결정하며
// 개발자가 화면에서 잘 보이고 있는지에 대한 확인을 시켜주는 편리한 기능이다.
#Preview("iPhone 17") {
    ContentView()
}
