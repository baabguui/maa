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
    
    static var allCase: [Tab] {
        return Tab.allCases.map {$0}
    }
}

struct BottomTab: View {
    @Binding var currentTab: Tab
    let tabWidth: CGFloat
    var body: some View {
        HStack {
            ForEach(Tab.allCase, id: \.self) { tab in
                
                Button { currentTab = tab } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: tabWidth * 0.3,
                               height: tabWidth * 0.14)
                        .foregroundStyle(.maaButton)
                        .overlay(
                            Text("\(tab.rawValue)")
                                .foregroundStyle(.second)
                                .font(.system(.body,
                                              weight: .medium))
                        )
                    
                    if tab != .setting {
                        Spacer().frame(width: 3)
                    }
                    
                }
            }
        }.frame(width: tabWidth, 
                height: tabWidth * 0.19)
    }
}

#Preview {
    BottomTab(currentTab: .constant(.todo), tabWidth: 393)
}
