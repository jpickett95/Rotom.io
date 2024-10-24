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
    var settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    // MARK: - -- Methods
    @ViewBuilder
    func getPage(page: Page) -> some View {
        switch page {
        case .home:
            ContentView()
        case .pokedex:
            CustomNavigationStack {
                Text("Pokedex")
            } contentView: {
                PokedexView(viewModel: PokedexViewModel(networkManager: NetworkManager(), settings: self.settings))
            }
        case .pokemonDeatils:
            PokemonDetailsTabView()
        }
    }
    
    @ViewBuilder
    func getSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .gameSelection:
            GameSheetView()
        }
    }
    
    func showGameSelection() {
        sheet = .gameSelection
    }
    
    func navigateToHome() {
        path.append(Page.home)
    }
    
    func navigateToPokedex() {
        path.append(Page.pokedex)
    }
    
    func navigateToPokemonDetails() {
        path.append(Page.pokemonDeatils)
    }
}

// MARK: Pages
enum Page: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case home,
         pokedex,
         pokemonDeatils
}

// MARK: Sheets
enum Sheet: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case gameSelection
}
