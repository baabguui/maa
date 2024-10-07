//
//  MaaView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    var mapleAPI: MapleAPI
    
    @State var currentTab: Tab = .todo
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            InfoView()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.maaBackground)
                VStack {
                    Spacer().frame(height: 20)
                    switch currentTab {
                    case .todo:
                        TodoView()
                            .frame(height: 480)
                    case .info:
                        InfoDetailView()
                            .frame(height: 480)
                    case .setting:
                        SettingView()
                            .frame(height: 480)
                    }
                    Spacer()
                    BottomTab(currentTab:$currentTab)
                    Spacer().frame(height: 8)
                }
            }.frame(height: 565)
            Spacer()
            
        }.frame(maxWidth: .infinity,
                alignment: .center)
        
        //        .onAppear {
        //            //                insertBasicTodo(modelContext: modelContext)
        //            mapleAPI.getCharacterOcid(characterName: "포토킷") {heroInfo in
        //                let newHero = Hero(date: heroInfo.date,
        //                                   characterName: heroInfo.character_name,
        //                                   worldName: heroInfo.world_name,
        //                                   characterGender: heroInfo.character_gender,
        //                                   characterClass: heroInfo.character_class,
        //                                   characterClassLevel: heroInfo.character_class_level,
        //                                   characterLevel: heroInfo.character_level,
        //                                   characterExp: heroInfo.character_exp,
        //                                   characterExpRate: heroInfo.character_exp_rate,
        //                                   characterGuildName: heroInfo.character_guild_name,
        //                                   characterImage: heroInfo.character_image,
        //                                   characterDateCreate: heroInfo.character_date_create,
        //                                   accessFlag: heroInfo.access_flag,
        //                                   liberationQuestClearFlag: heroInfo.liberation_quest_clear_flag)
        //                modelContext.insert(newHero)
        //            }
        //        }
        
    }
}


#Preview {
    ContentView(mapleAPI: MapleAPI())
}
