//
//  AddTodoView.swift
//  maa
//
//  Created by baabguui on 10/8/24.
//

import SwiftUI

struct AddTodo: View {
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

#Preview {
    AddTodo()
}
