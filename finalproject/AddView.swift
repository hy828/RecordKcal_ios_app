//
//  AddView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct AddView: View { // 添加记录
    
    @State private var foodName = ""
    @State private var calories = ""
    @Binding var food: FoodItem
    @Binding var showAddView: Bool
    
    var body: some View {
        VStack {
            // 食物名字
            Text("Food Name:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            TextField("Enter the food what you ate", text: $foodName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            // 食物的热量，以kcal为单位
            Text("Calories(kcal):")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            TextField("What is its calories", text: $calories)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            HStack {
                // 取消按钮
                Button(action: {
                    cancel()
                }) {
                    Text("Cancel")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .bold()
                }
                .padding(.horizontal)
                
                // 提交按钮
                Button(action: {
                    addFood()
                }) {
                    Text("Add")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .bold()
                }
                .padding(.horizontal)
            }
            .padding(20)
            Spacer()
        }
        .padding(.top, 50)
        .padding()
    }
    
    func addFood() { // 处理表单提交的逻辑
        print("Food Name: \(foodName)")
        print("Calories: \(calories)")
        showAddView.toggle()
    }
    
    func cancel() { // 处理按钮取消的逻辑
        showAddView.toggle()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(food: .constant(FoodItem(foodName: "aaa", kcal: 100, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!)), showAddView: .constant(true))
    }
}
