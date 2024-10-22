//
//  Coordinator.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

// MARK: Coordinator
import Foundation
import SwiftUI

// MARK: - - Protocol
protocol Coordinating {
    
}

// MARK: - - Service
@MainActor
final class Coordinator: ObservableObject, Coordinating {
    
    // MARK: - -- Properties
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @EnvironmentObject var settings: Settings
    
    // MARK: - -- Methods
    @ViewBuilder
    func getPage(page: Page) -> some View {
        switch page {
        case .main:
            ContentView()
        case .pokedex:
            PokedexView(viewModel: PokedexViewModel(networkManager: NetworkManager(), settings: settings))
        default :
            ContentView()
        }
    }
    
    @ViewBuilder
    func getSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .gameSelection:
            GameSheetView()
        }
    }
}

// MARK: Pages
enum Page: CaseIterable {
    case main,
         pokedex
        
}

// MARK: Sheets
enum Sheet: CaseIterable {
    case gameSelection
}
