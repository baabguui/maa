//
//  InfoView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct InfoView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var hero: [Hero] // TODO: - 현재 선택된 캐릭터 정보만 가져오기
    let temp: [String] = ["유니온", "무릉도장", "인기도"] // TODO: -
    let temp2: [String] = ["characterGuildName", "연합"]
    
    var body: some View {
        InfoContainer {
            HStack {
                LeftColumn
                Spacer()
                CenterColumn
                Spacer()
                RightColumn
            }
        }
    }
    
    private var LeftColumn: some View {
        VStack(spacing: 3) {
            Spacer().frame(height: 11)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 100, height: 20)
                    .foregroundStyle(.characterInfo)
                Text("\(hero.first?.characterClass)")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            ForEach(temp, id: \.self) {content in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 20)
                        .foregroundStyle(.todoFont)
                    
                    HStack {
                        Text(content)
                            .font(.caption2)
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }.padding(.horizontal, 10)
                }
            }
            Spacer().frame(height: 6)
        }
    }
    
    private var CenterColumn: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 15)
                    .foregroundStyle(.characterInfo)
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 7)
                        .foregroundStyle(.characterInfo)
                    Spacer().frame(height: 8)
                }
                Text("Lv. \(hero.first?.characterLevel)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
            }.frame(width: 70)
            
            Spacer()
            // TODO: - case 나눠서 처리
            AsyncImage(url: URL(string: "\(hero.first?.characterImage ?? "")"))
                .frame(height: 84)
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 100, height: 20)
                    .foregroundStyle(.accent)
                Text("\(hero.first?.characterName)")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            Spacer().frame(height: 6)
        }
    }
    private var RightColumn: some View {
        VStack(spacing: 3) {
            Spacer()
            ForEach(temp2, id: \.self) {content in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 20)
                        .foregroundStyle(.todoFont)
                    
                    HStack {
                        Text(content)
                            .font(.caption2)
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }.padding(.horizontal, 10)
                }
            }
            Spacer().frame(height: 6)
        }
    }
}

#Preview {
    InfoView()
}
