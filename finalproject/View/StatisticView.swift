//
//  StatisticView.swift
//  finalproject
//
//  Created by lhy on 2023/6/19.
//

import SwiftUI
import Charts

struct CaloriesCount: Identifiable { // 日期以及对应的总热量
    let id = UUID()
    let date: Date
    let calories: Int
    
    init(date: Date, calories: Int) {
        self.date = date
        self.calories = calories
    }
}

struct StatisticView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Food.entity(), sortDescriptors: [])
    var foods: FetchedResults<Food>
    
    @State var dateInterval = DateInterval.init(start: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1))!, end: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!) // 日期范围
    @State var data: [CaloriesCount] = [] // 日期范围内的数据
    
    var body: some View {
        VStack {
            Spacer()
            DatePicker("Select Start Date", selection: $dateInterval.start, displayedComponents: .date) // 起始日
                .padding(.vertical, 15)
            DatePicker("Select End Date", selection: $dateInterval.end, displayedComponents: .date) // 结束日
                .padding(.vertical, 5)
            Spacer()
            if !data.isEmpty {
                GroupBox ( "Line Chart - Calories Count") { // 显示折线图
                    Chart {
                        ForEach(data) { i in
                            LineMark(
                                x: .value("Week Day", i.date, unit: .day),
                                y: .value("Step Count", i.calories)
                            )
                        }
                    }
                }
            } else {
                Text("No data available.")
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            calculateCalories(startDate: dateInterval.start, endDate: dateInterval.end)
        }
        .onChange(of: dateInterval) { date in
            calculateCalories(startDate: date.start, endDate: date.end)
        }
    }
    
    func calculateCalories(startDate: Date, endDate: Date) { // 计算每一天卡路里的总和
        data.removeAll()
        let dayDurationInSeconds: TimeInterval = 60*60*24
        for date in stride(from: startDate, to: endDate, by: dayDurationInSeconds) {
            print("Selected date: \(date)")
            let foodList =  foods.filter { food in
                guard let foodDate = food.date else { return false }
                return Calendar.current.isDate(foodDate, inSameDayAs: date)
            } // 根据日期重新筛选饮食列表
            let totalCalories = foodList.reduce(0) { $0 + Int($1.kcal) } // 计算总卡路里
            let newDay = CaloriesCount(date: date, calories: totalCalories)
            data.append(newDay)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
