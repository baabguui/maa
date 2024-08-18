//
//  MaaView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct MaaView: View {
    @Environment(\.modelContext) var modelContext
    var mapleAPI: MapleAPI
    
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
            
            .onAppear {
//                insertBasicTodo(modelContext: modelContext)
                mapleAPI.getCharacterOcid(characterName: "포토킷") {heroInfo in
                    let newHero = Hero(date: heroInfo.date, 
                                       characterName: heroInfo.character_name,
                                       worldName: heroInfo.world_name,
                                       characterGender: heroInfo.character_gender,
                                       characterClass: heroInfo.character_class,
                                       characterClassLevel: heroInfo.character_class_level,
                                       characterLevel: heroInfo.character_level,
                                       characterExp: heroInfo.character_exp,
                                       characterExpRate: heroInfo.character_exp_rate,
                                       characterGuildName: heroInfo.character_guild_name,
                                       characterImage: heroInfo.character_image,
                                       characterDateCreate: heroInfo.character_date_create,
                                       accessFlag: heroInfo.access_flag,
                                       liberationQuestClearFlag: heroInfo.liberation_quest_clear_flag)
                    modelContext.insert(newHero)
                }
            }
        }
    }
}


//#Preview {
//    MaaView()
//}
