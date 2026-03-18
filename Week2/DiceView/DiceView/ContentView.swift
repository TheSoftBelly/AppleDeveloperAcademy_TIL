//
//  ContentView.swift
//  DiceView
//
//  Created by Joon on 3/17/26.
//
//  다루는 주제 및 기술
//  버튼 생성 및 사용자 지정
//  클로저를 이용한 코드 실행
//  후행 클로저 구문
//  @State속성을 사용하여 뷰 업데이트
//  동적으로 조회수를 늘리는 방법ForEach

import SwiftUI


struct ContentView: View {
    @State private var numberOfDice: Int = 1
    
    var body: some View {
        VStack {
            Text("Dice Roller")
                .font(.largeTitle.lowercaseSmallCaps())
                .foregroundStyle(.white)
            
            HStack {
                ForEach(1...numberOfDice, id: \.description) { _ in
                    DiceView()
                }
            }
            HStack{
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    withAnimation {
                        numberOfDice += 1
                    }
                }
                .disabled(numberOfDice == 7)
                
                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    withAnimation {
                        if numberOfDice > 1 {
                            numberOfDice -= 1
                        }
                    }
                }
                .disabled(numberOfDice == 1)
            }
            .padding()
            .labelStyle(IconOnlyLabelStyle())
            .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBackground)
        .tint(.white)
    }
}


#Preview {
    ContentView()
}
