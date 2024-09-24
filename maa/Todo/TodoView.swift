//
//  TodoView.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import SwiftData
import SwiftUI

struct TodoView: View {
    @Environment(\.modelContext) var modelContext
    //    @Query var todos: [Todo]
    var todos: [Todo] = basicTodos
    @State var newContent: String = ""
    @State var newCategory: TodoCategory?
    @State var categoryPresented: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    Spacer().frame(height: 53)
                    ForEach(TodoCategory.allCases, id: \.self) {category in
                        VStack {
                            ForEach(todos.filter({$0.category == category}), id: \.self.id) {todo in
                                TodoItemContainer(category: todo.category, content: todo.content)
                            }
                            Spacer().frame(height: 23)
                        }
                    }
                }
            }
            AddTodo
        }
    }
    private var AddTodo: some View {
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
                    Button {} label: {
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

#Preview {
    TodoView()
}
