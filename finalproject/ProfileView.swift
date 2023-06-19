//
//  ProfileView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI
import CoreData

struct ProfileView: View { // 个人资料
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Profile.entity(), sortDescriptors: [])
    var data: FetchedResults<Profile>
    
    @State var name: String = "aaa"
    @State var age: Int = 0
    @State var gender: GenderSelection = GenderSelection.male
    @State var weight: Float = 0
    @State var height: Float = 0
    @State var bmi: Float = 0
    @State var goalWeight: Float = 0
    @State var goal: GoalSelection = GoalSelection.gain
    @State private var isEditMode = false
    @State var isPicker1Visible = false
    @State var isPicker2Visible = false
    @State var isPicker3Visible = false
    
    enum GoalSelection: String, CaseIterable { // 目标：增重/减重
        case loss = "LOSS WEIGHT"
        case gain = "GAIN WEIGHT"
    }
    
    enum GenderSelection: String, CaseIterable {
        case male = "MALE"
        case female = "FEMALE"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Avatar // 头像
                Name // 名字
                Age // 年龄
                Gender
                Weight // 体重
                Height // 身高
                BMI // BMI
                Goal // 目标
                GoalWeight // 目标体重
            }
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    isEditMode.toggle()
                    bmi = weight / ((height * height)/10000) // 计算bmi
                    if !isEditMode { // 不是编辑模式，保存刚刚修改的值
                        let newProfile = Profile(context: viewContext)
                        newProfile.name = name
                        newProfile.age = Int16(exactly: age)!
                        newProfile.gender = gender.rawValue
                        newProfile.weight = weight
                        newProfile.height = height
                        newProfile.bmi = bmi
                        newProfile.goal = goal.rawValue
                        newProfile.goalWeight = goalWeight

                        do {
                            try viewContext.save()
                        } catch {
                            print("Error saving record: \(error)")
                        }
                    }
                } label: {
                    Text(isEditMode ? "Save" : "Edit")
                        .bold()
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            if let profile = data.first {
                let profileName: String? = profile.name
                if let unwrappedName = profileName {
                    name = unwrappedName
                }
                age = Int(profile.age)
                if profile.gender == "MALE" {
                    gender = .male
                } else {
                    gender = .female
                }
                weight = profile.weight
                height = profile.height
                goalWeight = profile.goalWeight
                if profile.goal == "LOSS WEIGHT" {
                    goal = .loss
                } else {
                    goal = .gain
                }
                bmi = weight / ((height * height)/10000)
            }
        }
    }
    
    var Avatar: some View {
        Image("PersonImage")
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
    
    var Name: some View {
        HStack {
            Text("Name").bold()
            Spacer()
            if isEditMode {
                TextField("\(name)", text: $name)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            } else {
                Text("\(name)")
            }
        }
        .padding(10)
    }
    
    var Age: some View {
        HStack {
            Text("Age").bold()
            Spacer()
            if isEditMode {
                Button("\(age)") {
                    isPicker1Visible = true
                }
                .sheet(isPresented: $isPicker1Visible) {
                    Picker("Age", selection: $age) {
                        ForEach(0...100, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .presentationDetents([.fraction(0.3)])
                }
            } else {
                Text("\(age)")
            }
        }
        .padding(10)
    }
    
    var Gender: some View {
        HStack {
            Text("Gender").bold()
            Spacer()
            if isEditMode {
                Button(gender.rawValue) {
                    isPicker3Visible = true
                }
                .sheet(isPresented: $isPicker3Visible) {
                    Picker("Goal", selection: $gender) {
                        ForEach(Array(GenderSelection.allCases), id: \.self) { i in
                            Text(i.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .presentationDetents([.fraction(0.3)])
                }
            } else {
                Text(gender.rawValue)
            }
        }
        .padding(10)
    }
    
    var Weight: some View {
        HStack {
            Text("Weight(kg)").bold()
            Spacer()
            if isEditMode {
                TextField(String(format: "%.2f", weight), text: Binding<String>(
                    get: { String(weight) },
                    set: { weight = Float($0) ?? 0.0 }
                ))
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            } else {
                Text(String(format: "%.2f", weight))
            }
        }
        .padding(10)
    }
    
    var Height: some View {
        HStack {
            Text("Height(cm)").bold()
            Spacer()
            if isEditMode {
                TextField(String(format: "%.2f", height), text: Binding<String>(
                    get: { String(height) },
                    set: { height = Float($0) ?? 0.0 }
                ))
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            } else {
                Text(String(format: "%.2f", height))
            }
        }
        .padding(10)
    }
    
    var BMI: some View {
        HStack {
            Text("BMI(kg/m^2)").bold()
            Spacer()
            Text(String(format: "%.2f", bmi))
        }
        .padding(10)
    }
    
    var Goal: some View {
        HStack {
            Text("Goal").bold()
            Spacer()
            if isEditMode {
                Button(goal.rawValue) {
                    isPicker2Visible = true
                }
                .sheet(isPresented: $isPicker2Visible) {
                    Picker("Goal", selection: $goal) {
                        ForEach(Array(GoalSelection.allCases), id: \.self) { i in
                            Text(i.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .presentationDetents([.fraction(0.3)])
                }
            } else {
                Text(goal.rawValue)
            }
        }
        .padding(10)
    }
    
    var GoalWeight: some View {
        HStack {
            Text("Goal Weight(kg)").bold()
            Spacer()
            if isEditMode {
                TextField(String(format: "%.2f", goalWeight), text: Binding<String>(
                    get: { String(goalWeight) },
                    set: { goalWeight = Float($0) ?? 0.0 }
                ))
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            } else {
                Text(String(format: "%.2f", goalWeight))
            }
        }
        .padding(10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
