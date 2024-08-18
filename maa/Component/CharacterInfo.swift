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
    
    @Query var hero: [Hero] // TODO: - 현재 선택된 캐릭터 정보만 가져오기
    let temp: [String] = ["유니온", "무릉도장", "인기도"] // TODO: -
    let temp2: [String] = ["characterGuildName", "연합"]
    
    let InfoWidth: CGFloat
    let InfoHeight: CGFloat
    
    let titleColor: Color = Color(red: 201/255, green: 226/255, blue: 24/255)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: InfoWidth,
                       height: InfoHeight)
                .foregroundColor(.maaBackground)
            
            VStack(spacing: 0) {
                
                HStack {
                    Text("CHARACTER INFO")
                        .font(.footnote)
                        .fontWeight(.black)
                        .foregroundStyle(titleColor)
                    Spacer()
                }.padding(.horizontal, InfoWidth * 0.07)
                
                Spacer().frame(height: InfoHeight * 0.05)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: InfoWidth * 0.91,
                           height: InfoHeight * 0.73)
                    .foregroundStyle(.white)
                    .overlay( // MARK: - 흰 바탕 내용물
                        HStack {
                            
                            Spacer().frame(width: InfoWidth * 0.02)
                            
                            // MARK: - 첫번째 줄
                            VStack(spacing: 3) {
                                Spacer().frame(height: InfoHeight * 0.04 - 3)
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: InfoWidth * 0.25,
                                           height: InfoHeight * 0.11)
                                    .foregroundStyle(.characterInfo)
                                    .overlay(
                                        Text("\(hero.first?.characterClass)")
                                            .font(.caption2)
                                            .fontWeight(.light)
                                            .foregroundStyle(.white))
                                
                                Spacer()
                                
                                ForEach(temp, id: \.self) {content in
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: InfoWidth * 0.25,
                                               height: InfoHeight * 0.11)
                                        .foregroundStyle(.todoFont)
                                        .overlay(
                                            HStack {
                                                Text(content)
                                                    .font(.caption2)
                                                    .fontWeight(.light)
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                            }.padding(.horizontal, 10)
                                        )
                                }
                                Spacer().frame(height: InfoHeight * 0.04 - 3)
                            }
                            
                            Spacer()
                            
                            // MARK: - 두번째 줄
                            VStack(spacing: 0) {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: InfoWidth * 0.18, height: InfoHeight * 0.08)
                                    .foregroundStyle(.characterInfo)
                                    .overlay(
                                        VStack(spacing: 0) {
                                            Rectangle()
                                                .frame(height: InfoHeight * 0.04)
                                                .foregroundStyle(.characterInfo)
                                            Spacer().frame(height: InfoHeight * 0.04)
                                        }.overlay(
                                            Text("Lv. \(hero.first?.characterLevel)")
                                                .font(.caption2)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                        )
                                    )
                                
                                Spacer()
                                // TODO: - case 나눠서 처리
                                AsyncImage(url: URL(string: "\(hero.first?.characterImage ?? "")"))
                                    .frame(width: InfoWidth * 0.13,
                                           height: InfoHeight * 0.43)
                                
                                Spacer().frame(height: InfoHeight * 0.02)
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: InfoWidth * 0.25,
                                           height: InfoHeight * 0.11)
                                    .foregroundStyle(.accent)
                                    .overlay(
                                        Text("\(hero.first?.characterName)")
                                            .font(.caption2)
                                            .fontWeight(.light)
                                            .foregroundStyle(.white)
                                    )
                                
                                Spacer().frame(height: InfoHeight * 0.04)
                            }
                            
                            Spacer()
                            
                            // MARK: - 세번째 줄
                            VStack(spacing: 3) {
                                Spacer()
                                ForEach(temp2, id: \.self) {content in
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: InfoWidth * 0.25,
                                               height: InfoHeight * 0.11)
                                        .foregroundStyle(.todoFont)
                                        .overlay(
                                            HStack {
                                                Text(content)
                                                    .font(.caption2)
                                                    .fontWeight(.light)
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                            }.padding(.horizontal, 10)
                                        )
                                }
                                
                                Spacer().frame(height: InfoHeight * 0.04 - 3)
                            }
                            Spacer().frame(width: InfoWidth * 0.02)
                        }
                    )
            }
        }
    }
}

#Preview {
    CharacterInfo(InfoWidth: 393 * 0.97, InfoHeight: 852 * 0.21)
}
