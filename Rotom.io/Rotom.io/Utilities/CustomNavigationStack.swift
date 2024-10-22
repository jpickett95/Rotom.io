//
//  CustomNavigationStack.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

import SwiftUI

struct CustomNavigationStack<NavigationTitle: View, Content: View>: View {
    // MARK: Properties
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var coordinator: Coordinator
    var title: NavigationTitle
    var contentView: Content
    
    // MARK: Lifecycle
    init(@ViewBuilder title: @escaping () -> NavigationTitle, @ViewBuilder contentView: @escaping () -> Content) {
        self.contentView = contentView()
        self.title = title()
    }
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            
            contentView
            
        }
        .toolbar {
            // MARK: Navigation Title
            ToolbarItem(placement: .principal) {
                title
                .font(.title2).bold()
            }
            
            // MARK: Selected Game
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    coordinator.showGameSelection()
                } label: {
                    Image(systemName: "circle")
                }
            }
        }
    }
}

// MARK: Preview
#Preview {
    MainView()
        .environmentObject(Settings())
        .environmentObject(Coordinator())
}
