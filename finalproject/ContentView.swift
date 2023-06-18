//
//  ContentView.swift
//  finalproject
//
//  Created by lhy on 2023/6/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selection : Tab = .homeView
    @State var foodList: [FoodItem] = FoodItem.data
    @State var date: Date = Date()
    
    enum Tab {
        case homeView
        case addView
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                HomeView(foodList: $foodList, selectedDate: $date)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                AddView()
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
