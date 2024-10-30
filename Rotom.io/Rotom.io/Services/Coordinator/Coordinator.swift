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
    private var pokemonEntry: PokemonEntry?
    
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
                Text("Pokédex")
            } contentView: {
                PokedexView(viewModel: PokedexViewModel(networkManager: NetworkManager(), settings: self.settings))
            }
        case .pokemonDeatils:
            if let entry = pokemonEntry {
                PokemonDetailsTabView(viewModel: PokemonDetailsViewModel(networkManager: NetworkManager(), entry: entry, settings: settings))
            }
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
    
    func navigate(to destination: Page) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToHome() {
        path.removeLast(path.count)
    }
    
//    func navigateToPokedex() {
//        if path.count > 0 {
//            path = path.
////            path.append(Page.pokedex)
//        } else {
//            path.append(Page.pokedex)
//        }
//    }
    
    func navigateToPokemonDetails(entry: PokemonEntry) {
        self.pokemonEntry = entry
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
