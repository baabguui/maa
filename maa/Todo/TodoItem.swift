//
//  TodoItemView.swift
//  maa
//
//  Created by baabguui on 10/8/24.
//

import SwiftUI

struct TodoItem: View {
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

#Preview {
    TodoItem(todo: basicTodos[0])
}
