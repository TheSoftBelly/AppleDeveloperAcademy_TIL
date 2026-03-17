//
//  Box.swift
//  practice
//
//  Created by Joon on 3/12/26.
//

import SwiftUI

public struct Box: View {
    public var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.boxRedBack)
                
                HStack(alignment: .center) {
                    // 왼쪽: 텍스트
                    VStack(alignment: .leading, spacing: 6) {
                        Text("FASTEST LAP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))
                        
                        Text("1:12.909")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // 오른쪽: LEC 뱃지
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

#Preview {
    Box()
}
