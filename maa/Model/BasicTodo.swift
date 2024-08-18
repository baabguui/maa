//
//  BasicTodo.swift
//  maa
//
//  Created by baabguui on 8/17/24.
//

import SwiftData

// TODO: - 기본 투두들 넣어줘야 하는데 나중에 업데이트할거 생각하면 어캐.. 함?

func insertBasicTodo(modelContext: ModelContext) {
    for todo in basicTodos {
        modelContext.insert(todo)
    }
    return 
}

let basicTodos: [Todo] = [
    Todo(categoryRawValue: "day", content: "일간 퀘스트", checkDate: nil,isActive: true, isCustom: false),
    Todo(categoryRawValue: "day",content: "몬스터 파크", checkDate: nil,isActive: true, isCustom: false),
    Todo(categoryRawValue: "day", content: "일간 보스", checkDate: nil, isActive: false,isCustom: false),
    Todo(categoryRawValue: "day", content: "데일리 기프트/출석", checkDate: nil, isActive: true,isCustom: false),
    Todo(categoryRawValue: "week", content: "주간 퀘스트", checkDate: nil,isActive: false, isCustom: false),
    Todo(categoryRawValue: "event", content: "주간 보스", checkDate: nil, isActive: true,isCustom: false),
    Todo(categoryRawValue: "event", content: "강렬 힘 결정", checkDate: nil,isActive: true, isCustom: false),
    Todo(categoryRawValue: "event", content: "이벤트 주간 출석", checkDate: nil, isActive: false,isCustom: false)]
