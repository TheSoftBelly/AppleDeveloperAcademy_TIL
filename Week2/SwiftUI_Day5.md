# SwiftUI Day 5 - DiceView (@State, Button, ForEach, withAnimation)

---

## 📁 프로젝트 파일 구조

```
DiceView/
├── DiceViewApp.swift     # @main 진입점
├── ContentView.swift     # 주사위 개수 관리 + 버튼 UI
└── DiceView.swift        # 개별 주사위 뷰 + Roll 버튼
```

---

## 🎲 `@State` — 뷰 내부 상태 관리

`@State`는 뷰 내부에서 값이 바뀌면 **자동으로 UI를 다시 그려주는** 속성 래퍼다.

```swift
@State private var numberOfDice: Int = 1
@State private var canChangeNumber: Int = 1
```

> `@State` 없이 일반 변수를 바꾸면 UI는 업데이트되지 않는다.
> 값이 변경될 때마다 `body`가 재실행된다.

---

## 🔤 `let` vs `var` — 상수와 변수

```swift
let diceNumber: Int = 1        // 상수 — 이후 변경 불가
@State private var canChangeNumber: Int = 1  // 변수 — 이후 변경 가능
```

| 키워드 | 의미 | 특징 |
|--------|------|------|
| `let` | 상수 | 선언 후 값 변경 불가 |
| `var` | 변수 | 언제든 값 변경 가능 |

> UI에서 값을 바꿔야 한다면 반드시 `var` + `@State` 조합을 사용한다.

---

## 🔘 `Button` — 버튼 생성 및 액션 클로저

```swift
// 텍스트 + SF Symbol 버튼
Button("Add Dice", systemImage: "plus.circle.fill") {
    numberOfDice += 1
}
.disabled(numberOfDice == 7)   // 조건에 따라 비활성화
```

```swift
// Roll 버튼 (스타일 적용)
Button("Roll") {
    canChangeNumber = Int.random(in: 1...6)
}
.buttonStyle(.bordered)
```

### Button 주요 수식어

| 수식어 | 설명 |
|--------|------|
| `.disabled(조건)` | 조건이 true이면 버튼 비활성화 |
| `.buttonStyle(.bordered)` | 테두리 있는 기본 버튼 스타일 |
| `.labelStyle(IconOnlyLabelStyle())` | 아이콘만 표시 (텍스트 숨김) |

---

## 🔁 `ForEach` — 동적 뷰 반복 생성

```swift
HStack {
    ForEach(1...numberOfDice, id: \.description) { _ in
        DiceView()
    }
}
```

> `ForEach`의 `id:` 파라미터는 각 항목을 구분하는 고유 식별자다.
> `\.description`은 값을 문자열로 변환해 ID로 사용한다.

---

## ✨ `withAnimation` — 부드러운 애니메이션 적용

```swift
Button("Add Dice", systemImage: "plus.circle.fill") {
    withAnimation {
        numberOfDice += 1
    }
}
```

> `withAnimation { }` 블록 안에서 `@State` 값을 변경하면 SwiftUI가 **자동으로 전환 애니메이션**을 적용한다.

---

## 🎲 `Int.random(in:)` — 범위 내 난수 생성

```swift
canChangeNumber = Int.random(in: 1...6)
```

> `1...6`은 1 이상 6 이하의 닫힌 범위.
> 주사위 면에 맞게 1~6 사이 난수를 생성한다.

---

## 🖼 SF Symbol 동적 사용

```swift
Image(systemName: "die.face.\(canChangeNumber).fill")
```

> 문자열 보간으로 `canChangeNumber` 값에 따라 아이콘 이름이 동적으로 변한다.
> `die.face.1.fill` ~ `die.face.6.fill` SF Symbol이 각 주사위 면을 표현한다.

---

## 📋 전체 구조 요약

```swift
// ContentView — 주사위 개수 관리
struct ContentView: View {
    @State private var numberOfDice: Int = 1

    var body: some View {
        VStack {
            HStack {
                ForEach(1...numberOfDice, id: \.description) { _ in
                    DiceView()
                }
            }
            HStack {
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    withAnimation { numberOfDice += 1 }
                }
                .disabled(numberOfDice == 7)

                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    withAnimation { if numberOfDice > 1 { numberOfDice -= 1 } }
                }
                .disabled(numberOfDice == 1)
            }
        }
    }
}

// DiceView — 개별 주사위
struct DiceView: View {
    @State private var canChangeNumber: Int = 1

    var body: some View {
        VStack {
            Image(systemName: "die.face.\(canChangeNumber).fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .foregroundStyle(.black, .white)
            Button("Roll") {
                withAnimation { canChangeNumber = Int.random(in: 1...6) }
            }
            .buttonStyle(.bordered)
        }
    }
}
```

---

## ✅ 핵심 정리

| 개념 | 내용 |
|------|------|
| `@State` | 뷰 내부 상태 — 값 변경 시 UI 자동 갱신 |
| `let` vs `var` | 상수(불변) vs 변수(가변) |
| `Button` | 액션 클로저 + `.disabled()` 로 비활성화 |
| `ForEach` | 범위/배열을 반복해 동적으로 뷰 생성 |
| `withAnimation` | 상태 변경을 애니메이션으로 전환 |
| `Int.random(in:)` | 범위 내 난수 생성 |

---

## ✅ 다음에 배울 것

- `@Binding`으로 자식 뷰에서 부모 상태 수정
- `@State`를 배열에 적용해 리스트 관리
- `List` + `TextField`로 입력 기반 UI 구성
