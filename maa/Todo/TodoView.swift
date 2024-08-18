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
    @Query var todos: [Todo]
    @State var isPresented: Bool = false
//    var Todos: [Todo] = basicTodos
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                // MARK: - 편집 버튼
                Button {isPresented = true} label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width,
                               height: height * 0.07)
                        .foregroundStyle(.maaButton)
                        .overlay(
                            Text("편집")
                                .foregroundStyle(.second)
                                .font(.system(.caption,
                                              weight: .medium)))
                    
                }
                ForEach(Category.allCases, id: \.self) { category in
                    // MARK: - todo 묶음
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text(category.deadline)
                                .foregroundStyle(.white)
                                .font(.system(.caption2))
                        }
                        ForEach(todos.filter{
                            $0.category == category &&
                            $0.isActive }, id: \.self.id) { todo in
                            // MARK: - todo 하나
                            HStack {
                                Button {} label: {
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(.white, lineWidth: 2)
                                        .frame(width: height * 0.03, height: height * 0.03)
                                        .shadow(radius: 2, x: 2, y: 2)
                                }
                                Text(todo.content)
                                    .foregroundStyle(.todoFont)
                                    .font(.system(.footnote))
                                    .fontWeight(.medium)
                                
                                Spacer()
                            }.frame(height: height * 0.04)
                        }
                    }
                    .padding()
                    .frame(width: width)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(category.categoryColor)
                    )
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            EditTodoView(width: width, height: height)
                .presentationBackground(.maaBackground)
        }
    }
}

#Preview {
    TodoView(width: 300, height: 700)
}
