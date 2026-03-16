# SwiftUI Day 2 - F1 앱 홈화면 완성 (TabView, MapBox, Box)

---

## 📁 프로젝트 파일 구조

```
practiceApp/
├── Assets.xcassets
│   ├── BoxBlueBack.colorset     # 카드 파란 배경색
│   ├── BoxRedBack.colorset      # 카드 빨간 배경색
│   ├── MapBackground.colorset   # 지도 배경색
│   └── Map.imageset             # 서킷 지도 이미지
├── Components/
│   ├── Header.swift
│   ├── Box.swift                # 패스티스트 랩 카드
│   ├── HomeMapInfo.swift        # Box 컨테이너
│   └── MapBox.swift             # 서킷 지도 컴포넌트
├── Screens/
│   └── HomeView.swift           # 홈 화면 (Header + MapBox + Box)
└── ContentView.swift            # TabView 최상위 진입점
```

---

## 📱 TabView — 바텀 탭바

### 기본 구조

```swift
struct ContentView: View {
    @State private var selectedTab = 2  // 기본 탭: Home (index 2)

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Results view")
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Results")
                }
                .tag(0)

            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
        }
        .accentColor(.red)  // 선택된 탭 색상
    }
}
```

### TabView 사용 시 핵심 규칙

| 규칙 | 이유 |
|------|------|
| `TabView`는 최상위 진입점(`ContentView`)에 배치 | 탭바는 앱 전체 레벨의 UI이기 때문 |
| 각 탭 내부에서 `NavigationStack` 따로 추가 | 탭마다 독립적인 네비게이션 스택이 필요 |
| 컴포넌트로 분리하지 않는다 | TabView는 앱 구조 자체이지 재사용 컴포넌트가 아님 |

> **바텀바는 `NavigationView`가 아닌 `TabView`로 만든다.**
> `NavigationStack`은 각 탭 내부에서 필요할 때만 추가하는 것이 맞다.

---

## 🗺 MapBox — 지도 이미지 컴포넌트

```swift
struct MapBox: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.mapBackground)
                .cornerRadius(20)

            Image("Map")           // Assets에 등록된 이미지 이름
                .resizable()       // 크기 조절 가능하게
                .scaledToFit()     // 비율 유지하며 맞춤
                .cornerRadius(20)
                .padding(10)
        }
    }
}
```

> `Image("Map")`은 `Assets.xcassets`에 등록된 이미지를 이름으로 불러온다.
> `.resizable()` 없이는 이미지 크기를 조절할 수 없다.

---

## 🃏 Box — 패스티스트 랩 카드

```swift
struct Box: View {
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.boxRedBack)

                HStack(alignment: .center) {
                    // 왼쪽: 텍스트 정보
                    VStack(alignment: .leading, spacing: 6) {
                        Text("FASTEST LAP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))

                        Text("1:12.909")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    // 오른쪽: 드라이버 뱃지
                    Text("LEC")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white.opacity(0.2))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .frame(height: 100)
        }
    }
}
```

### 카드 레이아웃 패턴

```
ZStack (배경 도형 + 컨텐츠)
└── HStack
    ├── VStack (텍스트 그룹)
    │   ├── 라벨 (작은 글씨)
    │   └── 값 (큰 글씨)
    ├── Spacer()
    └── 뱃지 (배경 있는 텍스트)
```

> 카드 안에 뱃지를 만들 때 `.background(RoundedRectangle(...).fill(...))`를 사용해서 텍스트에 직접 배경을 붙인다.

---

## 🎨 Assets — 커스텀 컬러셋

Xcode Assets에 컬러셋을 추가하면 `Color` extension 없이도 사용 가능하다.

```swift
// Assets에 "BoxRedBack" 컬러셋 등록 후
.foregroundColor(.boxRedBack)        // Color("BoxRedBack") 대신 .boxRedBack으로 사용
.foregroundColor(.mapBackground)
```

> Assets 기반 컬러는 다크모드 대응이 쉽다 — Light/Dark 각각 다른 색상을 지정할 수 있음.

---

## 🏠 HomeView — 화면 조합

```swift
struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Header()
                    .padding(10)
                MapBox()
                Box()
                Spacer()
            }
        }
    }
}
```

> 컴포넌트를 작게 쪼개두면 화면(`Screen`)은 단순히 컴포넌트를 조합하는 역할만 한다.

---

## ✅ 다음에 배울 것

- 각 탭에 실제 화면 연결 (Results, Racing, Standings)
- `NavigationStack`으로 탭 내부 화면 전환
- 리스트 데이터 연동 (`ForEach`, 모델 구조체)
