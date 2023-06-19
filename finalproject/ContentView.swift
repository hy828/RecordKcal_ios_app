//
//  ContentView.swift
//  finalproject
//
//  Created by lhy on 2023/6/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selection = 1
    @State var date: Date = Date()

    var body: some View {
        TabView(selection: $selection) {
            HomeView(selectedDate: $date) // 首页
                .tabItem { Image(systemName: "house.fill") }
                .tag(1)
             StatisticView() // 数据统计界面
                .tabItem { Image(systemName: "chart.bar.xaxis") }
                .tag(2)
            ProfileView() // 个人资料界面
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
