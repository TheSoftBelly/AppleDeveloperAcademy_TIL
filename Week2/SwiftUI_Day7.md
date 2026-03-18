# SwiftUI Day 7 - ScoreKeeper (Identifiable, Stepper, ForEach 바인딩)

---

## 📁 프로젝트 파일 구조

```
ScoreKeeper/
├── ScoreKeeperApp.swift   # @main 진입점
├── Player.swift           # Identifiable 모델 구조체
└── ContentView.swift      # 플레이어 목록 + 점수 관리 UI
```

---

## 🧩 `Identifiable` 프로토콜 — 고유 식별 가능한 모델

```swift
struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int = 0
}
```

> `Identifiable`을 채택하면 `ForEach`에서 `id:` 파라미터 없이 사용할 수 있다.
> `UUID()`는 앱 실행마다 전 세계에서 유일한 식별자를 자동 생성한다.
> `id`는 변하지 않으므로 `let`, 나머지는 수정 가능하므로 `var`.

### Identifiable 채택 전후 비교

```swift
// Identifiable 없을 때 — id: 명시 필요
ForEach(players, id: \.name) { player in ... }

// Identifiable 있을 때 — 생략 가능
ForEach(players) { player in ... }
```

---

## 🔗 `ForEach($배열)` — 배열 요소에 바인딩으로 접근

```swift
ForEach($players) { $player in
    TextField("Name", text: $player.name)
    Stepper("\(player.score)", value: $player.score)
}
```

> `ForEach($players)` 처럼 `$`를 붙이면 각 요소를 **바인딩**으로 받을 수 있다.
> `$player.name`, `$player.score` 처럼 하위 프로퍼티까지 직접 수정 가능하다.
> 이렇게 하면 부모 뷰의 `@State` 배열이 자동으로 업데이트된다.

| 형태 | 용도 |
|------|------|
| `ForEach(players)` | 읽기 전용 (값 표시) |
| `ForEach($players)` | 읽기 + 쓰기 (값 수정) |

---

## 🔢 `Stepper` — 증감 버튼으로 숫자 조절

```swift
Stepper("\(player.score)", value: $player.score)
```

> `Stepper`는 `+` / `-` 버튼으로 숫자를 1씩 올리고 내리는 UI 컴포넌트다.
> 첫 번째 파라미터는 레이블(표시 텍스트), `value:`는 바인딩된 숫자 값이다.

### 범위 제한도 가능

```swift
Stepper("\(player.score)", value: $player.score, in: 0...100)
```

---

## ➕ 버튼으로 배열에 새 항목 추가

```swift
@State private var newPlayer: String = ""
@State private var players: [Player] = [
    Player(name: "Asher", score: 0),
    Player(name: "Joon", score: 0),
    Player(name: "Nessa", score: 0)
]

Button("Add Player", systemImage: "plus.circle.fill") {
    players.append(Player(name: newPlayer, score: 0))
}
```

> `players.append()`로 새 `Player`를 추가하면 `ForEach`가 자동으로 UI를 갱신한다.

---

## 📋 전체 코드 요약

```swift
// Player.swift
struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int = 0
}

// ContentView.swift
struct ContentView: View {
    @State private var newPlayer: String = ""
    @State private var players: [Player] = [
        Player(name: "Asher", score: 0),
        Player(name: "Joon", score: 0),
        Player(name: "Nessa", score: 0)
    ]

    var body: some View {
        VStack {
            ForEach($players) { $player in
                TextField("Name", text: $player.name)
                Stepper("\(player.score)", value: $player.score)
            }

            Button("Add Player", systemImage: "plus.circle.fill") {
                players.append(Player(name: newPlayer, score: 0))
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}
```

---

## ✅ 핵심 정리

| 개념 | 내용 |
|------|------|
| `Identifiable` | 고유 `id`를 보장하는 프로토콜 — `ForEach`에서 `id:` 생략 가능 |
| `UUID()` | 전 세계 유일한 식별자 자동 생성 |
| `ForEach($배열)` | 배열 요소를 바인딩으로 받아 직접 수정 |
| `Stepper` | `+` / `-` 버튼으로 숫자 값 증감 |
| `players.append()` | 배열에 새 요소 추가 → UI 자동 갱신 |

---

## ✅ 다음에 배울 것

- `.onDelete` 로 리스트 항목 스와이프 삭제
- `@Binding`으로 자식 뷰에서 부모 배열 수정
- `NavigationStack` + `NavigationLink`로 화면 전환
