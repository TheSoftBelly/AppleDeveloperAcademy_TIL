# SwiftUI Day 6 - Pick-A-Pal (List, TextField, @State 배열, 옵셔널)

---

## 📁 프로젝트 파일 구조

```
Pick-A-Pal/
├── Pick_A_PalApp.swift   # @main 진입점
└── ContentView.swift     # 이름 목록 + 랜덤 선택 UI
```

---

## 📋 `List` — 스크롤 가능한 목록 UI

```swift
List {
    ForEach(nameList, id: \.description) { name in
        Text(name)
    }
}
```

> `List`는 iOS 기본 테이블 스타일의 스크롤 목록을 만든다.
> `ForEach`로 배열 데이터를 항목으로 렌더링한다.

---

## 📝 `TextField` — 텍스트 입력 필드

```swift
TextField("Add Name", text: $nameToAdd)
    .autocorrectionDisabled()
    .onSubmit {
        if !nameToAdd.isEmpty {
            nameList.append(nameToAdd)
            nameToAdd = ""
        }
    }
```

### 주요 포인트

| 요소 | 설명 |
|------|------|
| `"Add Name"` | placeholder 텍스트 |
| `text: $nameToAdd` | 입력값을 `@State` 변수에 양방향 바인딩 |
| `.autocorrectionDisabled()` | 자동 수정 비활성화 |
| `.onSubmit { }` | Return 키 눌렀을 때 실행할 클로저 |

> `$nameToAdd`처럼 `$` 접두사를 붙이면 **바인딩(Binding)** 이 된다.
> 바인딩은 뷰와 상태를 **양방향**으로 연결한다 — 사용자가 입력하면 변수가 바뀌고, 변수가 바뀌면 화면이 바뀐다.

---

## 📦 `@State` 배열 — 동적 리스트 관리

```swift
@State private var nameList: [String] = ["Asher", "Tom", "Jude", "Kevin"]
```

```swift
// 항목 추가
nameList.append(nameToAdd)

// 입력 필드 초기화
nameToAdd = ""
```

> `@State`는 배열에도 적용 가능하다.
> `.append()` 로 요소를 추가하면 `List`가 자동으로 업데이트된다.

---

## 🎲 `randomElement()` — 배열에서 랜덤 요소 추출

```swift
if let randomName = nameList.randomElement() {
    pickedName = randomName
} else {
    pickedName = ""
}
```

> `randomElement()`는 배열이 비어 있으면 `nil`을 반환한다 — 반환 타입이 **옵셔널(Optional)**.
> `if let`으로 옵셔널을 안전하게 언래핑한다.

---

## ❓ 옵셔널 (Optional) 기초

옵셔널은 값이 있을 수도, 없을 수도 있는 타입이다.

```swift
var pickedName: String?   // String 또는 nil

// if let — 값이 있을 때만 실행
if let randomName = nameList.randomElement() {
    pickedName = randomName   // 값 있음
} else {
    pickedName = ""           // nil (배열 비어 있음)
}
```

| 상황 | 반환값 |
|------|--------|
| 배열에 항목이 있음 | 랜덤 요소 (String) |
| 배열이 비어 있음 | `nil` |

> `if let`은 옵셔널 바인딩이라고 부른다. nil이면 else 블록이 실행된다.

---

## 💬 삼항 연산자로 빈 텍스트 처리

```swift
Text(pickedName.isEmpty ? " " : pickedName)
```

> `pickedName`이 비어 있으면 공백(" ")을 표시해 레이아웃 공간을 유지한다.
> 값이 있으면 선택된 이름을 표시한다.

---

## 📋 전체 코드

```swift
struct ContentView: View {
    @State private var nameList: [String] = ["Asher", "Tom", "Jude", "Kevin"]
    @State private var nameToAdd = ""
    @State private var pickedName = ""

    var body: some View {
        VStack {
            Text(pickedName.isEmpty ? " " : pickedName)

            List {
                ForEach(nameList, id: \.description) { name in
                    Text(name)
                }
            }

            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty {
                        nameList.append(nameToAdd)
                        nameToAdd = ""
                    }
                }

            Divider()

            Button("Pick Random Name") {
                if let randomName = nameList.randomElement() {
                    pickedName = randomName
                } else {
                    pickedName = ""
                }
            }
        }
        .padding()
    }
}
```

---

## ✅ 핵심 정리

| 개념 | 내용 |
|------|------|
| `List` + `ForEach` | 배열을 스크롤 목록으로 렌더링 |
| `TextField` + `$바인딩` | 입력값을 `@State` 변수에 양방향 연결 |
| `.onSubmit` | Return 키 눌렀을 때 실행되는 클로저 |
| `@State` 배열 | `.append()` 로 항목 추가 시 UI 자동 갱신 |
| `randomElement()` | 배열 랜덤 요소 추출 — 옵셔널 반환 |
| `if let` | 옵셔널 바인딩 — nil 안전 처리 |

---

## ✅ 다음에 배울 것

- `.onDelete` 로 리스트 항목 삭제
- `@Binding`으로 부모 뷰의 배열을 자식 뷰에서 수정
- `NavigationStack` + `NavigationLink`로 화면 이동
