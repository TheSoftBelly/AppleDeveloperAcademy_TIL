//
//  Header.swift
//  practice
//
//  Created by Joon on 3/11/26.
//

import Foundation
import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            // 메뉴 목록으로 가는 아이콘
            Button(action: {}) {
                Image(systemName: "line.3.horizontal") // SF Symbols를 사용해서 아이콘을 지정
                    .foregroundColor(.red)
                    .font(.system(size: 30))
            }
            // 레이스정보를 위한 스택 (왼쪽정렬)
            VStack(alignment: .leading) {
                // 왼쪽 정렬을 위해서 .leading
                Text("Monaco Grand Prix")
                    .font(.title3) // 크기: largeTitle > title > title2 > title3 > headline > body
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
            Spacer() // 기어 버튼을 오른쪽으로 밀기
            // Spacer는 남은 공간을 전부 차지하는 빈 뷰이다.
            
            // 배경 있는 설정버튼
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.boxRedBack.opacity(0.3))
                Button(action: {}) {
                    Image(systemName: "gearshape")// SF Symbols를 사용해서 아이콘을 지정
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    Header()
        .background(Color.black)
    //이게 홈에서 설명하는 전체 프리뷰를 그냥 블랙으로 간다하게 지정해서 보는 법
}
