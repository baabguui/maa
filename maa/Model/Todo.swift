//
//  Todo.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import Foundation
import SwiftData
import SwiftUI

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
    var checkDate: Date?
    var isDone: Bool {
        guard let check = checkDate else { return false }
        switch self.category {
        case .day:
            return Calendar.current.isDate(
                check,
                equalTo: Date(),
                toGranularity: .day)
        case .week:
            return Calendar.current.isDate(
                check,
                equalTo: Date(),
                toGranularity: .weekOfYear)
        case .event:
            return false // TODO: - checkDate가 저번주 목요일 0시 ~ 이번주 목요일 0시 사이인지 확인
        }
    }
    // MARK: - 삭제 가능 여부
    var isCustom: Bool
    
    init(categoryRawValue: String, index: Int, content: String, checkDate: Date? = nil, isCustom: Bool) {
        self.categoryRawValue = categoryRawValue
        self.index = index
        self.content = content
        self.checkDate = checkDate
        self.isCustom = isCustom
    }
}

enum Category: String, CaseIterable {
    case day
    case week
    case event
    
    var deadline: String {
        switch self {
        case .day:
            return "매일 0시까지"
        case .week:
            return "월요일 0시까지"
        case .event:
            return "목요일 0시까지"
        }
    }
    
    var categoryColor: Color {
        switch self {
        case .day:
            return Color.first
        case .week:
            return Color.second
        case .event:
            return Color.third
        }
    }
    
    static var allCase: [Category] {
        Category.allCases.map {$0}
    }
}
