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
    Todo(categoryRawValue: "day", index: 0, content: "일간 퀘스트", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "day", index: 1, content: "몬스터 파크", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "day", index: 2, content: "일간 보스", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "day", index: 3, content: "데일리 기프트/출석", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "week", index: 0, content: "주간 퀘스트", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "event", index: 0, content: "주간 보스", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "event", index: 1, content: "강렬 힘 결정", checkDate: nil, isCustom: false),
    Todo(categoryRawValue: "event", index: 2, content: "이벤트 주간 출석", checkDate: nil, isCustom: false)]
