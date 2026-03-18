//
//  DiceView.swift
//  DiceView
//
//  Created by Joon on 3/17/26.
//

import SwiftUI

// let과 var의 차이!!
// let은 상수란, 변하지 않는 값 상수로 선언하게 되면 이후에 값을 변경할 수 없다.
// var은 변수(변할 수 있는 값) 변수로 선언하게 되면 이후에 값을 변경할 수 있다



struct DiceView: View {
    let diceNumber: Int = 1
    @State private var canChangeNumber: Int = 1

//    init(canChageNumber: Int) {
//        self.canChangeNumber = canChageNumber
//    }
    // diceNumber = 2
    //--> Error 왜냐하면 상수이기 때문에
    // Pass 왜냐하면 변수이기 때문에
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(canChangeNumber).fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.black,.white)//가로세로 비율을 1로 설정
            
            Button("Roll") {
                withAnimation{
                    canChangeNumber = Int.random(in: 1...6)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    DiceView()
}
