//
//  AddView.swift
//  finalproject
//
//  Created by lhy on 2023/6/18.
//

import SwiftUI

struct AddView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Food Name:")
                
            }
            HStack {
                Text("Calories(kcal):")
                
            }
            Button(action: {
                addFood()
            }) {
                Text("Done")
            }
        }
    }
    
    func addFood() {
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
