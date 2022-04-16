//
//  TimerGameApp.swift
//  TimerGame
//
//  Created by Cristian Rojas on 16/04/2022.
//

import SwiftUI

@main
struct TimerGameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
