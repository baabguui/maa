//
//  EditTodoView.swift
//  maa
//
//  Created by baabguui on 8/17/24.
//

import SwiftData
import SwiftUI

struct EditTodoView: View {
    @Environment(\.modelContext) var modelContext
    @Query var todos: [Todo]
    @State var newCategory: Category?
    @State var categoryPresented: Bool = false
    @State var newTodo: String = ""
    @State var deletePresented: Bool = false
//    let todos: [Todo] = basicTodos
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            // TODO: - 파일 나눠야 하나?
            // MARK: - todo 추가
            HStack {
                Button { categoryPresented.toggle() } label: {
                    Text("\((newCategory != nil) ? newCategory!.rawValue : "카테고리")")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: height * 0.06))
                }
                TextField("", text: $newTodo)
                    .frame(height: height * 0.08)
                Button {
                    guard let category = newCategory else { return }
                    
                    let new = Todo(categoryRawValue: category.rawValue,
                                   content: newTodo,
                                   isActive: true,
                                   isCustom: true)
                    
                    modelContext.insert(new)
                    
                    newCategory = nil
                    newTodo = ""
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .fontWeight(.black)
                }
            }
            .padding(.horizontal, 10)
            .frame(width: width)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white))
            
            if categoryPresented {
                HStack {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button {
                            newCategory = category
                            categoryPresented = false
                        } label: {
                            Text("\(category)")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(height: height * 0.05)
                                        .foregroundStyle(category.categoryColor))
                        }
                    }
                }
                .frame(width: width, height: height * 0.07)
            } else {
                Spacer().frame(height: height * 0.07)
                
            }
            
            // MARK: - todo 목록
            ScrollView(.vertical) {
                VStack {
                    ForEach(Category.allCases, id: \.self) {category in
                        ForEach(todos.filter({
                            $0.category == category &&
                            $0.isActive }),
                                id: \.self.id) { todo in
                            Button {
                                todo.isActive.toggle()
                            } label: {
                                HStack {
                                    Text(todo.content)
                                        .font(.system(.footnote))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.todoFont)
                                    Spacer()
                                    Text(category.deadline)
                                        .font(.system(.caption2))
                                        .foregroundStyle(.todoFont)
                                }
                                .padding(.horizontal, 10)
                                .frame(height: height * 0.08)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(category.categoryColor))
                            }
                        }
                    }
                    
                    Divider()
                        .frame(width: width, height: 2)
                        .background(.second)
                        .padding(.vertical, 20)
                    
                    // MARK: - 삭제
                    HStack {
                        Spacer()
                        
                        Button {
                            deletePresented.toggle()
                        } label: {
                            Image(systemName: "trash.fill")
                                .font(.title3)
                                .fontWeight(.black)
                                .foregroundStyle(deletePresented ? .red : .second)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // TODO: - 코드 반복
                    ForEach(Category.allCases, id: \.self) {category in
                        ForEach(todos.filter({
                            $0.category == category &&
                            $0.isActive == false}),
                                id: \.self.id) {todo in
                            Button {
                                todo.isActive.toggle() // TODO: - 버튼 말고 탭
                            } label: {
                                HStack {
                                    Text(todo.content)
                                        .font(.system(.footnote))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.todoFont)
                                    Spacer()
                                    Text(category.deadline)
                                        .font(.system(.caption2))
                                        .foregroundStyle(.todoFont)
                                    
                                    if deletePresented && todo.isCustom {
                                        Button {
                                            // TODO: - 삭제
                                        } label: {
                                            Circle()
                                                .frame(width: width * 0.1)
                                                .foregroundStyle(.red)
                                                .overlay(
                                                    Image(systemName: "minus")
                                                        .foregroundStyle(.second)
                                                        .fontWeight(.black))
                                        }
                                    }
                                }
                                .padding(.horizontal, 10)
                                .frame(height: height * 0.08)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(category.categoryColor))
                            }
                        }
                    }
                }
            }
            .frame(width: width, height: height)
        }
        .frame(width: width * 1.1, height: height * 1.3)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.maaBackground))
    }
}

#Preview {
    EditTodoView(width: 385, height: 852 * 0.75)
}
