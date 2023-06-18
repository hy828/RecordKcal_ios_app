//
//  HomeView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct HomeView: View { // 首页：展示某一天所增加或消耗的卡路里
    
    @Binding var foodList: [FoodItem] // 当日的饮食列表
    @State var totalCalories: Int = 123 // 当日的总卡路里
    @Binding var selectedDate: Date // 那一天的日期
    
    var body: some View {
        VStack {
            ShowDate // 显示当日日期
            Spacer()
            ShowCalories // 显示总卡路里
            Spacer()
            ShowFoodList // 显示当日饮食
        }
        .onAppear{
            foodList = FoodItem.data.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            totalCalories = foodList.reduce(0) { $0 + $1.kcal }
        }
        .onChange(of: selectedDate) { date in
            handleDateSelection(date) // 选择另一个日期后，更新总卡路里和饮食列表
        }
    }
    
    var ShowDate: some View {
        HStack {
            Spacer()
            Button(action: { // 选择前一天
                selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
            }, label: {
                Image(systemName: "chevron.left")
            })
            Spacer()
            DatePicker("", selection: $selectedDate, displayedComponents: .date) // 选择日期
                .labelsHidden()
            Spacer()
            Button(action: { // 选择后一天
                selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
            }, label: {
                Image(systemName: "chevron.right")
            })
            Spacer()
        }
        .padding()
    }
    
    var ShowCalories: some View {
        Text("\(totalCalories) kcal") // 以kcal为单位的总卡路里
            .font(.largeTitle)
            .bold()
            .overlay(
                Circle()
                    .stroke(.orange, lineWidth: 15)
                    .frame(width: 180, height: 180)
            )
            .padding()
    }
    
    var ShowFoodList: some View {
        VStack {
            if foodList.count == 0 { // 没有饮食记录
                Text("No record.")
            } else {
                ScrollView { // 当日的所有饮食记录
                    ForEach(foodList) { item in
                        HStack {
                            Text(item.foodName)
                                .bold()
                            Spacer()
                            Text("\(item.kcal) kcal")
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 5)
                        .font(.title3)
                    }
                    
                }
            }
        }
        .frame(minHeight: 400, maxHeight: 400)
    }
    
    func handleDateSelection(_ date: Date) { // 处理日期选择变化的逻辑
        print("Selected date: \(date)")
        foodList = FoodItem.data.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) } // 根据日期重新筛选饮食列表
        totalCalories = foodList.reduce(0) { $0 + $1.kcal } // 计算总卡路里
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(foodList: .constant(FoodItem.data), selectedDate: .constant(Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!))
    }
}
