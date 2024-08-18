//
//  MapleInfo.swift
//  maa
//
//  Created by baabguui on 8/17/24.
//

import SwiftData

// MARK: - API로 받은 데이터 저장할 구조체
struct HeroInfo: Codable {
    var date: String?
    var character_name: String
    var world_name: String
    var character_gender: String
    var character_class: String
    var character_class_level: String
    var character_level: Int
    var character_exp: Int
    var character_exp_rate: String
    var character_guild_name: String?
    var character_image: String
    var character_date_create: String
    var access_flag: String
    var liberation_quest_clear_flag: String
}

// TODO: - Todo랑 엮어야 함.
@Model
class Hero {
    var date: String?
    var characterName: String
    var worldName: String
    var characterGender: String
    var characterClass: String
    var characterClassLevel: String
    var characterLevel: Int
    var characterExp: Int
    var characterExpRate: String
    var characterGuildName: String?
    var characterImage: String
    var characterDateCreate: String
    var accessFlag: String
    var liberationQuestClearFlag: String
    
    init(date: String? = nil, characterName: String, worldName: String, characterGender: String, characterClass: String, characterClassLevel: String, characterLevel: Int, characterExp: Int, characterExpRate: String, characterGuildName: String? = nil, characterImage: String, characterDateCreate: String, accessFlag: String, liberationQuestClearFlag: String) {
        self.date = date
        self.characterName = characterName
        self.worldName = worldName
        self.characterGender = characterGender
        self.characterClass = characterClass
        self.characterClassLevel = characterClassLevel
        self.characterLevel = characterLevel
        self.characterExp = characterExp
        self.characterExpRate = characterExpRate
        self.characterGuildName = characterGuildName
        self.characterImage = characterImage
        self.characterDateCreate = characterDateCreate
        self.accessFlag = accessFlag
        self.liberationQuestClearFlag = liberationQuestClearFlag
    }
}
