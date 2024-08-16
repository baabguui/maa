//
//  Todo.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import Foundation
import SwiftData

@Model
class Todo {
    let id = UUID()
    var categoryRawValue: String
    var category:Category {
        get {
            Category(rawValue: categoryRawValue) ?? .day
        }
        set {
            categoryRawValue = newValue.rawValue
        }
    }
    var index: Int
    var content: String
    var checkDate: Date
    var isDone: Bool {
        switch self.category {
        case .day:
            return Calendar.current.isDate(
                self.checkDate,
                equalTo: Date(),
                toGranularity: .day)
        case .week:
            return Calendar.current.isDate(
                self.checkDate,
                equalTo: Date(),
                toGranularity: .weekOfYear)
        case .event:
            return false // TODO: - checkDate가 저번주 목요일 0시 ~ 이번주 목요일 0시 사이인지 확인
        }
    }
    // MARK: - 삭제 가능 여부
    var isCustom: Bool
    
    init(categoryRawValue: String, index: Int, content: String, checkDate: Date, isCustom: Bool) {
        self.categoryRawValue = categoryRawValue
        self.index = index
        self.content = content
        self.checkDate = checkDate
        self.isCustom = isCustom
    }
    
    
}

enum Category: String {
    case day
    case week
    case event
}
