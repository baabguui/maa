//
//  CharacterInfo.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct InfoContainer<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.maaBackground)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                content
            }.frame(width: 359, height: 131)
            VStack {
                Spacer().frame(height: 10)
                HStack {
                    Spacer().frame(width: 20)
                    Text("CHARACTER INFO")
                        .font(.system(size: 10, weight: .black))
                        .foregroundStyle(.infoGreen)
                    Spacer()
                }
                Spacer()
                HStack {
                    ForEach(0...2, id: \.self){i in
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 8)
                        if i == 1 {
                            Circle()
                                .foregroundStyle(.second)
                                .frame(width: 8)
                        }
                    }
                }
                Spacer().frame(height: 10)
            }
        }
        .frame(height: 197)
    }
}
