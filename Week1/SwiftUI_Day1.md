# SwiftUI Day 1 - F1 앱 헤더 만들기

---

## 📁 프로젝트 파일 구조

```
practiceApp/
├── Assets.xcassets          # 이미지, 색상 리소스
├── Components/
│   └── Header.swift         # 재사용 가능한 UI 컴포넌트
├── practiceApp.swift        # @main 진입점 - 앱이 시작되는 곳
└── Screens/
    └── HomeView.swift       # 실제 화면 단위
```

> **규칙**: Components = 재사용 가능한 작은 부품 / Screens = 실제 화면 단위

---


## 🎨 커스텀 컬러 정의 (Color Extension)

```swift
extension Color {
    static let f1Red = Color(red: 225/255, green: 6/255, blue: 0/255)
}

// 사용법
.foregroundColor(.f1Red)
.foregroundColor(.f1Red.opacity(0.3))  // 투명도 조절
```

> `extension`으로 Color를 확장하면 `.f1Red` 처럼 기본 색상처럼 사용 가능하다.

---

## 🖼 SF Symbols

Apple이 제공하는 **6,000개+ 무료 아이콘 라이브러리**. 설치 없이 바로 사용 가능.

```swift
Image(systemName: "line.3.horizontal")  // ☰ 목록
Image(systemName: "gearshape")          // ⚙️ 설정
```

> **Mac App Store에서 "SF Symbols" 앱 설치 및 FINDEER 설치** → 아이콘 검색 후 이름 복사해서 바로 사용 

---

## 📐 레이아웃 기초

### HStack / VStack / ZStack

| Stack | 방향 | 용도 |
|-------|------|------|
| `HStack` | 가로 (←→) | 버튼들을 옆으로 나열 |
| `VStack` | 세로 (↑↓) | 제목 + 부제목 세로 배치 |
| `ZStack` | 앞뒤 겹치기 | 배경 위에 컨텐츠 올리기 |

```swift
// 정렬 지정
HStack(alignment: .center) { }
VStack(alignment: .leading) { }   // 왼쪽 정렬
ZStack(alignment: .top) { }       // 위쪽 정렬
```

### Spacer()

```swift
HStack {
    Text("왼쪽")
    Spacer()       // 이게 중간을 채워서 양쪽으로 밀어냄
    Text("오른쪽")
}
```

> `Spacer()`는 가능한 모든 공간을 차지해서 다른 뷰들을 밀어냄.

---

## 🖤 전체 화면 검은 배경 만들기

```swift
struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {  // 컨텐츠를 위에서부터 시작
            Color.black
                .ignoresSafeArea()  // 노치/홈바 영역까지 색상 채우기
            
            VStack(alignment: .leading) {
                Header()
                Spacer()            // 헤더를 위로 밀어올림
            }
        }
    }
}
```

> **왜 ZStack?** `Color.black`을 배경으로 깔고, 그 위에 VStack을 올려야 하기 때문.
> `.ignoresSafeArea()` 없으면 노치/홈바 부분이 흰색으로 남음.

---

## 🔴 RoundedRectangle + ZStack 버튼

```swift
ZStack {
    RoundedRectangle(cornerRadius: 10)
        .frame(width: 50, height: 50)
        .foregroundColor(.f1Red.opacity(0.3))  // 반투명 배경
    Button(action: {}) {
        Image(systemName: "gearshape")
            .foregroundColor(.red)
            .font(.system(size: 30))
    }
}
```

> ZStack으로 도형 위에 버튼을 겹쳐서 배경 있는 버튼 만들기.

---

## 🔤 텍스트 스타일링

```swift
Text("Monaco Grand Prix")
    .font(.largeTitle)         // 크기: largeTitle > title > title2 > title3 > headline > body
    .font(.title3)
    .font(.system(size: 30))   // 직접 크기 지정
    .bold()                    // 굵게
    .foregroundColor(.white)   // 글자색
    .foregroundColor(.red)
```

---

## 👁 Preview 활용법

```swift
// 기본 프리뷰
#Preview {
    Header()
}

// 배경색 지정해서 보기 (실제 앱 환경처럼)
#Preview {
    Header()
        .background(Color.black)
}

// 전체 화면으로 보기
#Preview {
    HomeView()
}
```

> `#Preview`는 실제 앱에 영향 없음. 개발 중 UI 확인용.

---

## 📋 오늘 만든 헤더 전체 코드

```swift
// Header.swift
import SwiftUI

extension Color {
    static let f1Red = Color(red: 225/255, green: 6/255, blue: 0/255)
}

struct Header: View {
    var body: some View {
        HStack {
            // 햄버거 메뉴 버튼
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.red)
                    .font(.system(size: 30))
            }
            
            // 레이스 정보 (왼쪽 정렬)
            VStack(alignment: .leading) {
                Text("Monaco Grand Prix")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.red)
                    Text("Live • Lap 42/78")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            Spacer()  // 기어 버튼을 오른쪽으로 밀기
            
            // 설정 버튼 (배경 있는 버튼)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.f1Red.opacity(0.3))
                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                }
            }
        }
        .padding(.horizontal)
    }
}
```

---

## ✅ 다음에 배울 것

- 바텀 네비게이션바 만들어서 화면전환시키기
- 홈 화면 컨텐츠 채우기 위한 컴포넌트 생성 (레이스 카드, 순위 등)
