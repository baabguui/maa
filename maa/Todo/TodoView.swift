//
//  TodoView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct TodoView: View {
    
    var body: some View {
        ZStack {
            TodoListView()
            AddTodo()
        }
    }
    
    private struct TodoListView: View {
        @Environment(\.modelContext) var modelContext
        
        @Query var todos: [Todo]
        //    var todos: [Todo] = basicTodos
        
        var body: some View {
            ScrollView(.vertical) {
                VStack {
                    Spacer().frame(height: 53)
                    ForEach(TodoCategory.allCases, id: \.self) { category in
                        VStack {
                            ForEach(todos.filter({$0.category == category}), id: \.self.id) { todo in
                                TodoItem(todo: todo)
                            }
                            Spacer().frame(height: 23)
                        }
                    }
                }
            }
            .task {
                // TODO: - 자정에 한번만 실행하도록 변경 예정, 함수도 수정 필요
                for todo in todos {
                    guard let checkDate = todo.checkDate else { continue }
                    todo.isDone = refreshTodo(type: todo.category, checkDate: checkDate)
                }
            }
            //        .task {
            //            try? modelContext.delete(model: Todo.self)
            //            insertBasicTodo(modelContext: modelContext)
            //        }
        }
        
        private func refreshTodo(type category: TodoCategory, checkDate date: Date) -> Bool {
            switch category {
            case .day:
                return Calendar.current.isDate(
                    date,
                    equalTo: Date(),
                    toGranularity: .day)
            case .week:
                return Calendar.current.isDate(
                    date,
                    equalTo: Date(),
                    toGranularity: .weekOfYear)
            case .event:
                return false
            }
        }
    }
}

#Preview {
    TodoView()
}
