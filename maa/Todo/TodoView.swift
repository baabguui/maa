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
    
    
    private struct TodoItem: View {
        @Environment(\.modelContext) var modelContext
        var todo: Todo
        @State var content: String
        init(todo: Todo) {
            self.todo = todo
            content = todo.content
        }
        
        @State var isEditing: Bool = false
        @State var alertDelete: Bool = false
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(todo.category.categoryColor)
                HStack {
                    Spacer().frame(width: 11)
                    Button {
                        if !todo.isDone {
                            todo.checkDate = Date()
                        }
                        todo.isDone.toggle()
                        modelContext.insert(todo)
                    } label: {
                        ZStack {
                            Rectangle()
                                .shadow(color: .black.opacity(0.25),
                                        radius: 1, x: 2, y: 2)
                                .foregroundStyle(.characterInfo)
                                .frame(width: 20, height: 20)
                            Rectangle()
                                .foregroundStyle(.todoFont)
                                .frame(width: 16, height: 16)
                            if todo.isDone {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 16, weight: .black))
                            }
                        }
                    }
                    Spacer().frame(width: 15)
                    if isEditing {
                        TextField(content, text: $content)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .onSubmit {
                                todo.content = content
                                isEditing = false
                                modelContext.insert(todo)
                            }
                        Spacer()
                        Button {
                            todo.content = content
                            isEditing = false
                            modelContext.insert(todo)
                        } label: {
                            Text("완료")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.accent)
                        }
                        Spacer().frame(width: 10)
                    } else {
                        Text(todo.content)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.todoFont)
                    }
                    Spacer()
                    
                }
            }
            .frame(width: 359, height: 40)
            .onTapGesture(count: 2) {
                if todo.isCustom {
                    isEditing = true
                }
            }
            .onLongPressGesture {
                if todo.isCustom {
                    alertDelete = true
                }
            }
            .alert("삭제하시겠습니까?", isPresented: $alertDelete) {
                Button("확인") {
                    modelContext.delete(todo)
                }
                Button("취소") {
                    alertDelete = false
                }
            }
        }
    }
    
    private struct AddTodo: View {
        @Environment(\.modelContext) var modelContext
        @State var newContent: String = ""
        @State var newCategory: TodoCategory?
        @State var categoryPresented: Bool = false
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .frame(width: 359, height: 40 )
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.accent)
                                .frame(width: 55, height: 32)
                            Button {categoryPresented.toggle()} label: {
                                Text(newCategory?.rawValue ?? "카테고리")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 10,
                                                  weight: .medium))
                            }
                        }
                        Spacer().frame(minWidth: 8)
                        if categoryPresented {
                            HStack {
                                ForEach(TodoCategory.allCases, id: \.self) { category in
                                    Button {
                                        newCategory = category
                                        categoryPresented = false
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(category.categoryColor)
                                                .frame(width: 60, height: 25)
                                            Text("\(category)")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .frame(width: 250)
                        } else {
                            TextField("", text: $newContent)
                                .frame(width: 250)
                        }
                        Spacer().frame(minWidth: 8)
                        Button {
                            guard let category = newCategory else { return }
                            let newTodo = Todo(categoryRawValue: category.rawValue, content: newContent)
                            modelContext.insert(newTodo)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.accent)
                                .font(.system(size: 20,
                                              weight: .black))
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TodoView()
}
