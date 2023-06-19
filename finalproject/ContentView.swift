//
//  ContentView.swift
//  finalproject
//
//  Created by lhy on 2023/6/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showAddView = false
    @State private var selection = 1
    @State private var oldSelection = 1
    @State var date: Date = Date()

    var body: some View {
        TabView(selection: $selection) {
            HomeView(selectedDate: $date) // 首页
                .tabItem { Image(systemName: "house.fill") }
                .tag(1)
             Text("") // 添加记录的界面
                .tabItem { Image(systemName: "plus.circle.fill") }
                .tag(2)
            ProfileView() // 个人资料界面
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
        .onChange(of: selection) { // 处理以sheet代替第二个tabItem
            if selection == 2 {
                self.showAddView = true
                self.selection = self.oldSelection
            } else {
                self.oldSelection = $0
            }
        }
        .sheet(isPresented: $showAddView) { // 添加记录的界面以sheet的形式展开
            AddView(showAddView: $showAddView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
