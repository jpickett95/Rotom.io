//
//  CustomNavigationStack.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

import SwiftUI

struct CustomNavigationStack<NavigationTitle: View, Content: View>: View {
    // MARK: Properties
    @State var showingSheet: Bool = false
    var title: NavigationTitle
    var contentView: Content
    
    // MARK: Lifecycle
    init(showingSheet: Bool, @ViewBuilder title: @escaping () -> NavigationTitle, @ViewBuilder contentView: @escaping () -> Content) {
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
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "circle")
                }
                .sheet(isPresented: $showingSheet) {
                    GameSheetView()
                }
            }
            
        }
    }
}

// MARK: Preview
#Preview {
    ContentView()
        .environmentObject(Settings())
}
