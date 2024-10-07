//
//  BottomTab.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case todo = "할 일"
    case info = "정보"
    case setting = "설정"
}

struct BottomTab: View {
    @Binding var currentTab: Tab
    var body: some View {
        HStack {
            Spacer()
            ForEach(Tab.allCases, id: \.self) { tab in
                Button { currentTab = tab } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .foregroundStyle(.maaButton)
                        
                        Text("\(tab.rawValue)")
                            .foregroundStyle(.second)
                            .font(.system(size: 14,
                                          weight: .medium))
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    BottomTab(currentTab: .constant(.todo))
}
