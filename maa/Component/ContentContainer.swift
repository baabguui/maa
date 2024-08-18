//
//  ContentView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftUI

struct ContentContainer: View {
    @Binding var currentTab: Tab
    let containerWidth: CGFloat
    let containerHeight: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.maaBackground)
            .frame(width: containerWidth,
                   height: containerHeight)
            .overlay(
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: containerWidth * 0.91,
                               height: containerHeight * 0.06)
                        .foregroundStyle(.third)
                        .overlay(
                            Text(currentTab.rawValue)
                                .foregroundStyle(.categoryFont)
                                .shadow(radius: 2, x: 2, y: 2)
                                .font(.callout))
                    switch currentTab { // TODO: - 보기 복잡함
                    case .todo:
                        TodoView(width: containerWidth * 0.91, height: containerHeight * 0.9)
                            .padding(.bottom, 40)
                    case .info:
                        InfoView()
                    case .setting:
                        SettingView()
                    }
                }
                    .frame(width: containerWidth * 0.91,
                           height: containerHeight * 0.9) ///나중에 없애
            )
    }
}

#Preview {
    ContentContainer(currentTab: .constant(.todo),
                     containerWidth: 393,
                     containerHeight: 852 * 0.7)
}
