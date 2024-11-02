//
//  AbilitiesViewComponent.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/1/24.
//

import SwiftUI

struct AbilitiesViewComponent: View {
    let pokemonAbilities: [PokemonAbility]
    let abilities: [String: Ability]
    let accentColor: Color
    let versions: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // MARK: Title
            Text("Abilities")
                .font(.title2).bold()
            
            ForEach (pokemonAbilities, id: \.self.slot) { ability in
                VStack(alignment: .leading) {
                    let abilityName = ability.ability.name
                    let pokemonAbility = abilities[abilityName]
                    
                    // filter language
                    let name  = pokemonAbility?.names.filter({$0.language.name == "en"}).first?.name
                    
                    // MARK: Ability Name
                    Label(name ?? "N/A", systemImage: ability.isHidden ? "eye.slash.fill" : "")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                    
                    // filter language
                    let englishFlavorTexts = abilities[abilityName]?.flavorTextEntries.filter({$0.language.name == "en"})
                    
                    // filter version
                    let versionFlavorText = englishFlavorTexts?.filter({ $0.versionGroup.name.contains( versions.first ?? "")}).last?.flavorText ?? englishFlavorTexts?.last?.flavorText ?? "N/A"
                    
                    // MARK: Ability Flavor Text
                    Text("\(versionFlavorText.replacingOccurrences(of: "\n", with: " "))")
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
