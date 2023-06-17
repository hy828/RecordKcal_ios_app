//
//  finalprojectApp.swift
//  finalproject
//
//  Created by lhy on 2023/6/17.
//

import SwiftUI

@main
struct finalprojectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
