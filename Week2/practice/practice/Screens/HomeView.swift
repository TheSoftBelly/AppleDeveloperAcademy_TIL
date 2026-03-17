//
//  HomeView.swift
//  practice
//
//  Created by Joon on 3/11/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {  // .top 항상 컨텐츠들을 위해서 시작하기 위해
            Color.black // 항상 배경을 검은색으로 하기 위해
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Header()
                    .padding(10)
                MapBox()

                Box()
                Spacer() // 헤더를 위로 올려버림
            } // 헤더와 스페이스를 주고 왼쪽부터 정렬을 함 + .leading이 해당 역할을 한다
        }
    }
}


#Preview {
    HomeView()
    // 여기다가 아예 전체 색깔을 지정할 수도 있다
}
