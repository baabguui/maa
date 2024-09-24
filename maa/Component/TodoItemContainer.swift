//
//  TodoItemContainer.swift
//  maa
//
//  Created by baabguui on 9/24/24.
//

import SwiftUI

struct TodoItemContainer: View {
    let category: TodoCategory
    let content: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(category.categoryColor)
            HStack {
                Spacer().frame(width: 11)
                ZStack {
                    Rectangle()
                        .shadow(color: .black.opacity(0.25),
                                radius: 1, x: 2, y: 2)
                        .foregroundStyle(.characterInfo)
                        .frame(width: 20, height: 20)
                    Rectangle()
                        .foregroundStyle(.todoFont)
                        .frame(width: 16, height: 16)
                }
                Spacer().frame(width: 15)
                Text(content)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.todoFont)
                Spacer()
            }
        }.frame(width: 359, height: 40)
    }
}

#Preview {
    TodoItemContainer(category: .day, content: "일간 퀘스트")
}
