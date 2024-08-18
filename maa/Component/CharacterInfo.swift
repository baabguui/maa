//
//  CharacterInfo.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct CharacterInfo: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var hero: [Hero]
    
    let InfoWidth: CGFloat
    let InfoHeight: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: InfoWidth,
                   height: InfoHeight)
            .foregroundColor(.maaBackground)
            .overlay(
                AsyncImage(url: URL(string: "\(hero.first?.characterImage ?? "")")))
    }
}

//#Preview {
//    CharacterInfo(InfoWidth: 393, InfoHeight: 852)
//}
