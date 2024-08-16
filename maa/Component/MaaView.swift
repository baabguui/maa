//
//  MaaView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftUI

struct MaaView: View {
    @State var currentTab: Tab = .todo
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 0.97
            let height = geometry.size.height
            
            VStack {
                
                Spacer()
                
                CharacterInfo(InfoWidth: width,
                              InfoHeight: height * 0.21)
                
                Spacer().frame(height: 3)
                
                ZStack {
                    ContentContainer(currentTab: $currentTab,
                                     containerWidth: width,
                                     containerHeight: height * 0.7)
                    VStack {
                        
                        Spacer()
                        
                        BottomTab(currentTab:$currentTab,
                                  tabWidth: width)
                    }.frame(height: height * 0.7)
                }
                
                Spacer()
                
            }.frame(maxWidth: .infinity,
                    alignment: .center)
        }
    }
}


#Preview {
    MaaView()
}
