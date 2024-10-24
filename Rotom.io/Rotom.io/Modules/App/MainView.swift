//
//  MainView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: Coordinator
    //@EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(page: .home)
            
                .navigationDestination(for: Page.self) { page in
                    coordinator.getPage(page: page)
                }
            
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.getSheet(sheet: sheet)
                }
        }
    }
}

#Preview {
    MainView()
        //.environmentObject(Settings())
        .environmentObject(Coordinator(settings: Settings()))
}
