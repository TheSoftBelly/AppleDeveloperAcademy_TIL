import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

// #Preview는 미리 보기에서 어떤 기기를 통해서 미리보기를 할지 결정하며
// 개발자가 화면에서 잘 보이고 있는지에 대한 확인을 시켜주는 편리한 기능이다.
#Preview("iPhone 17") {
    ContentView()
}
