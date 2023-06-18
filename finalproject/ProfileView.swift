//
//  ProfileView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct ProfileView: View { // 个人资料
    
    var name: String = "Law Han Yen"
    var age: Int = 22
    var weight: Float = 42.5
    var height: Float = 158.5
    var bmi: Float = 123
    var goal: GoalSelection = GoalSelection.gain
    
    enum GoalSelection {
        case loss
        case gain
    }
    
    var body: some View {
        NavigationStack {
            Name
            Age
            Weight
            Height
            Goal
            .navigationTitle("Profile")
        }
    }
    
    var Name: some View {
        HStack {
            Text("Name")
            Spacer()
            Text("\(name)")
        }
    }
    
    var Age: some View {
        HStack {
            Text("Age")
            Spacer()
            Text("\(age)")
        }
    }
    
    var Weight: some View {
        HStack {
            Text("Weight")
            Spacer()
            Text("\(weight)")
        }
    }
    
    var Height: some View {
        HStack {
            Text("Height")
            Spacer()
            Text("\(height)")
        }
    }
    
    var Goal: some View {
        HStack {
            Text("Goal")
            Spacer()
            Text("\(height)")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
