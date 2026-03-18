# SwiftUI Day 8 - ScoreKeeper 심화 (enum 상태머신, @Binding, Grid, Picker)

---

## 📁 프로젝트 파일 구조 (리팩토링 후)

```
ScoreKeeper/
├── ScoreKeeperApp.swift   # @main 진입점
├── Player.swift           # Identifiable 모델 구조체
├── GameState.swift        # 게임 상태 enum
├── Scoreboard.swift       # 게임 데이터 + 로직 구조체
├── SettingsView.swift     # 게임 규칙 설정 서브뷰
└── ContentView.swift      # 메인 UI
```

---

## 🎮 `enum` 상태머신 — 게임 흐름 관리

```swift
enum GameState: Equatable {
    case setup
    case playing
    case gameOver
}
```

> `enum`으로 게임 상태를 명확하게 표현할 수 있다.
> `Equatable`을 채택하면 `==` 비교가 가능해진다.
> `switch`문과 함께 쓰면 상태별 UI를 깔끔하게 분기할 수 있다.

```swift
switch scoreBoard.state {
case .setup:
    Button("Start Game", systemImage: "play.fill") {
        scoreBoard.state = .playing
        scoreBoard.resetScores(to: startingPoints)
    }
case .playing:
    Button("End Game", systemImage: "arrow.2.circlepath.circle") {
        scoreBoard.state = .gameOver
    }
case .gameOver:
    Button("Play Again", systemImage: "arrow.2.circlepath.circle") {
        scoreBoard.state = .setup
    }
}
```

> `switch`가 모든 케이스를 강제로 처리하므로 **컴파일 타임에 누락을 방지**할 수 있다.

---

## 📦 모델 분리 — `Scoreboard` 구조체

```swift
struct Scoreboard {
    var players: [Player] = [
        Player(name: "Joon", score: 0),
        Player(name: "Asher", score: 0),
        Player(name: "Nessa", score: 0),
    ]

    var state = GameState.setup

    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
```

> 여러 `@State` 변수를 하나의 구조체로 묶으면 관리가 훨씬 쉬워진다.
> ContentView에서는 `@State private var scoreBoard = Scoreboard()` 하나만 선언하면 된다.

### `mutating func` — 구조체 내부에서 프로퍼티 수정

```swift
mutating func resetScores(to newValue: Int) {
    for index in 0..<players.count {
        players[index].score = newValue
    }
}
```

> Swift의 `struct`는 기본적으로 **불변(immutable)**이다.
> 내부 프로퍼티를 수정하는 메서드에는 반드시 `mutating` 키워드를 붙여야 한다.
> `@State`로 선언된 구조체는 `mutating func` 호출이 가능하다.

---

## 🔗 `@Binding` — 자식 뷰에 데이터 전달

```swift
// SettingsView.swift (자식 뷰)
struct SettingsView: View {
    @Binding var startingPoints: Int

    var body: some View {
        Picker("Starting points", selection: $startingPoints) {
            Text("0 starting points").tag(0)
            Text("10 starting points").tag(10)
            Text("20 starting points").tag(20)
        }
    }
}

// ContentView.swift (부모 뷰)
@State private var startingPoints = 0

SettingsView(startingPoints: $startingPoints)
```

> `@Binding`은 부모 뷰의 `@State` 값을 자식 뷰에서 직접 읽고 쓸 수 있게 해준다.
> 자식 뷰에서 `$startingPoints`를 수정하면 부모 뷰에도 즉시 반영된다.

| 프로퍼티 래퍼 | 위치 | 역할 |
|-------------|------|------|
| `@State` | 부모 뷰 | 값의 원본 소유 |
| `@Binding` | 자식 뷰 | 원본 값에 대한 참조 |

---

## 🎛️ `Picker` — 선택 UI 컴포넌트

```swift
Picker("Starting points", selection: $startingPoints) {
    Text("0 starting points").tag(0)
    Text("10 starting points").tag(10)
    Text("20 starting points").tag(20)
}
```

> `selection:`에 바인딩 값을 연결하고, 각 옵션에 `.tag()`로 실제 저장될 값을 지정한다.
> `.tag()`의 타입이 `selection`의 타입과 일치해야 한다.

---

## 🗂️ `Grid` / `GridRow` — 표 형태 레이아웃

```swift
Grid {
    GridRow {
        Text("Player")
            .gridColumnAlignment(.leading)
        Text("Score")
    }
    .font(.headline)

    ForEach($scoreBoard.players) { $player in
        GridRow {
            TextField("Name", text: $player.name)
            Text("\(player.score)")
            Stepper("\(player.score)", value: $player.score)
                .labelsHidden()
        }
    }
}
```

> `Grid`는 행과 열이 자동으로 정렬되는 **표 형태** 레이아웃이다.
> 같은 열의 모든 셀이 가장 넓은 셀 기준으로 폭을 맞춘다.
> `.gridColumnAlignment(.leading)`으로 특정 열의 정렬을 지정할 수 있다.

---

## 🎨 `.background(.thinMaterial, in:)` — 머티리얼 배경

```swift
VStack { ... }
    .padding()
    .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
```

> `.thinMaterial`은 iOS의 **블러 유리 효과**를 적용하는 배경 스타일이다.
> `in:` 파라미터로 배경 모양(Shape)을 지정할 수 있다.
> `.rect(cornerRadius:)`로 모서리가 둥근 사각형을 만든다.

---

## 🔍 `@Previewable @State` — Preview에서 바인딩 테스트

```swift
#Preview {
    @Previewable @State var startingPoints = 10
    SettingsView(startingPoints: $startingPoints)
}
```

> `@Binding`을 요구하는 뷰는 Preview에서 `@Previewable @State`로 임시 상태를 만들어 테스트할 수 있다.

---

## ✅ 핵심 정리

| 개념 | 내용 |
|------|------|
| `enum` + `Equatable` | 상태를 타입 안전하게 표현, `switch`로 완전 분기 |
| 구조체 모델 분리 | 관련 데이터를 하나의 구조체로 묶어 `@State` 단순화 |
| `mutating func` | 구조체 내부 프로퍼티를 수정하는 메서드에 필수 |
| `@Binding` | 부모의 `@State`를 자식 뷰에서 읽기/쓰기 |
| `Picker` | `.tag()`로 선택 값 지정, `selection:`에 바인딩 연결 |
| `Grid` / `GridRow` | 자동 정렬되는 표 형태 레이아웃 |
| `.thinMaterial` | iOS 블러 유리 배경 효과 |
| `@Previewable @State` | Preview에서 `@Binding` 뷰 테스트 |

---

## ✅ 다음에 배울 것

- `.onDelete`로 리스트 항목 스와이프 삭제
- `NavigationStack` + `NavigationLink`로 화면 전환
- `sheet` / `fullScreenCover`로 모달 표시
