//
//  CharacterInfo.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftUI

struct CharacterInfo: View {
    let InfoWidth: CGFloat
    let InfoHeight: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: InfoWidth,
                   height: InfoHeight)
            .foregroundColor(.maaBackground)
    }
}

#Preview {
    CharacterInfo(InfoWidth: 393, InfoHeight: 852)
}
