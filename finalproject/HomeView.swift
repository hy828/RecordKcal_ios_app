//
//  HomeView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var foodList: [FoodItem]
    @State var totalCalories: Int = 123
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
                }, label: {
                    Image(systemName: "chevron.left")
                })
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                Spacer()
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                }, label: {
                    Image(systemName: "chevron.right")
                })
                Spacer()
            }
            
            .padding()
            Spacer()
            Text("\(totalCalories) kcal")
                .font(.largeTitle)
                .bold()
                .overlay(
                    Circle()
                        .stroke(.orange, lineWidth: 15)
                        .frame(width: 180, height: 180)
                )
                .padding()
            Spacer()
            VStack {
                if foodList.count == 0 {
                    Text("No record.")
                } else {
                    ScrollView {
                        ForEach(foodList) { item in
                            HStack {
                                Text(item.foodName)
                                    .bold()
                                Spacer()
                                Text("\(item.kcal)")
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
        .onChange(of: selectedDate) { date in
            handleDateSelection(date)
        }
    }
    
    func handleDateSelection(_ date: Date) {
        // 在这里处理日期选择变化的逻辑
        print("Selected date: \(date)")
        foodList = FoodItem.data.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
        totalCalories = foodList.reduce(0) { $0 + $1.kcal }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(foodList: .constant(FoodItem.data), selectedDate: .constant(Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!))
    }
}
