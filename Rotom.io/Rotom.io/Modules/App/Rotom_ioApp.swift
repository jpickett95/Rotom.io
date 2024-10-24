//
//  Rotom_ioApp.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI

@main
struct Rotom_ioApp: App {
    @StateObject var coordinator = Coordinator(settings: Settings())
    //let persistenceController = PersistenceController.shared

    // MARK: Body
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(coordinator)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
