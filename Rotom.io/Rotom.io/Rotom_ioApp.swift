//
//  Rotom_ioApp.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI

@main
struct Rotom_ioApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
