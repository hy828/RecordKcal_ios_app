//
//  AddView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct AddView: View { // 添加记录
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Food.entity(), sortDescriptors: [])
    var foods: FetchedResults<Food>
    
    @State private var foodName = ""
    @State private var calories = ""
    @State private var selectedDate = Date()
    @Binding var showAddView: Bool
    @Binding var addOnDate: Date
    
    var body: some View {
        VStack {
            // 食物名字
            Text("Food Name:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            TextField("Enter food name here", text: $foodName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            // 食物的热量，以kcal为单位
            Text("Calories(kcal):")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            TextField("Enter calories here", text: $calories)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            HStack {
                Text("Date:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                DatePicker("Date:", selection: $selectedDate, displayedComponents: .date) // 选择日期
                    .labelsHidden()
            }
            
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
        .onAppear {
            selectedDate = addOnDate
        }
    }
    
    func addFood() { // 处理表单提交的逻辑
        print("Submit: \(foodName) - \(calories) - \(selectedDate)")
        let newFood = Food(context: viewContext)
        newFood.foodName = foodName
        newFood.kcal = Int16(calories)!
        newFood.date = selectedDate

        do {
            try viewContext.save()
        } catch {
            print("Error saving record: \(error)")
        }
        addOnDate = selectedDate
        clear()
        showAddView.toggle()
    }
    
    func cancel() { // 处理按钮取消的逻辑
        clear()
        showAddView.toggle()
    }
    
    func clear() { // 清空表单数据
        foodName = ""
        calories = ""
        selectedDate = Date()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(showAddView: .constant(true), addOnDate: .constant(Date()))
    }
}
