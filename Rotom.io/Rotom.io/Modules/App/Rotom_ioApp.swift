//
//  Rotom_ioApp.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI

@main
struct Rotom_ioApp: App {
    //var settings = Settings()
    //let persistenceController = PersistenceController.shared

    // MARK: Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Settings())
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
