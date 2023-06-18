//
//  FoodItem.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import Foundation

struct FoodItem: Identifiable, Codable {
    var id = UUID()
    let foodName: String
    let kcal: Int
    let date: Date
}

extension FoodItem {
    static var data = [
        FoodItem(foodName: "Red Bean Bun", kcal: 215, date: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 18))!),
        FoodItem(foodName: "Chocolate bar 50g", kcal: 225, date: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 16))!),
        FoodItem(foodName: "Apple 100g", kcal: 52, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!),
        FoodItem(foodName: "White Rice 100g", kcal: 130, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 8))!),
        FoodItem(foodName: "Fried Egg", kcal: 75, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 28))!),
        FoodItem(foodName: "Milk 250ml", kcal: 163, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!),
    ]
}
