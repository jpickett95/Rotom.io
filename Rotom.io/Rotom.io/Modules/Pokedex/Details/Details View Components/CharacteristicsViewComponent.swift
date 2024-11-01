//
//  CharacteristicsViewComponent.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/30/24.
//

import SwiftUI

struct CharacteristicsViewComponent: View {
    let accentColor: Color
    let name: String
    let height: String
    let weight: String
    let captureRate: Int
    let firstAppearance: String
    let eggGroups: [NamedApiResource]
    let hatchCounter: Int
    let genderRate: Int
    let growthRate: String
    let baseExpYield: Int
    let category: String
    let stats: [PokemonStat]
    let isLegendary: Bool
    let isMythical: Bool
    let isBaby: Bool
    @State var showHatchCounterHelp = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Characteristics")
                .font(.title2).bold()
            
            // MARK: Name
            VStack(alignment: .leading) {
                Label("Name", systemImage: "person.text.rectangle.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(name)
            }
            
            // MARK: Pokemon Category
            VStack(alignment: .leading) {
                Label("Pokémon Category", systemImage: "folder.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(category)
            }
            
            // MARK: Height
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "ruler.fill")
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundStyle(accentColor)
                    
                    Text("Height")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                }
                
                Text(height)
            }
            
            // MARK: Weight
            VStack(alignment: .leading) {
                Label("Weight", systemImage: "scalemass.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(weight)
            }
            
            // MARK: Capture Rate
            VStack(alignment: .leading) {
                Label("Capture Rate", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                HStack {
                    Text("\(captureRate)")
                    
                    ProgressView(value: Float(captureRate), total: 255)
                        .padding(.horizontal, 20)
                }
            }
            
            // MARK: First Appearance
            VStack(alignment: .leading) {
                Label("First Appearance", systemImage: "1.magnifyingglass")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                let generation = firstAppearance.split(separator: "-").first?.capitalized ?? ""
                let romanNumeral = firstAppearance.split(separator: "-").last?.uppercased() ?? ""
                Text(generation + " \(romanNumeral)")
            }
            
            // MARK: Egg Groups
            VStack(alignment: .leading) {
                Label("Egg Groups", systemImage: "figure.2.and.child.holdinghands")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                HStack(spacing: 20) {
                    ForEach(eggGroups, id: \.self.name) { group in
                        getEggGroupLabel(group.name)
                    }
                }
            }
            
            // MARK: Hatch Time
            VStack(alignment: .leading) {
                HStack {
                    Label("Hatch Counter", systemImage: "hourglass")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                    
                    Spacer()
                    
                    Button("Help", systemImage: "info.circle") {
                        showHatchCounterHelp = true
                    }
                    .foregroundStyle(accentColor)
                }
                
                Text("\(hatchCounter)")
            }
            .alert("Hatching Eggs", isPresented: $showHatchCounterHelp) {
                Button("OK", role: .cancel) {
                    showHatchCounterHelp = false
                }
            } message: {
                Text("One must walk Y × ('hatch counter' + 1) steps before this Pokémon's egg hatches, unless utilizing bonuses like Flame Body's.\nY varies per generation. \n\nIn Generations II, III, and VII, Egg cycles are 256 steps long.\n\nIn Generation IV, Egg cycles are 255 steps long.\n\nIn Pokémon Brilliant Diamond and Shining Pearl, Egg cycles are also 255 steps long, but are shorter on special dates.\n\nIn Generations V and VI, Egg cycles are 257 steps long.\n\nIn Pokémon Sword and Shield, and in Pokémon Scarlet and Violet, Egg cycles are 128 steps long.")
            }

            // MARK: Gender Ratio
            VStack(alignment: .leading) {
                Label("Gender Ratio", systemImage: "figure.stand.dress.line.vertical.figure")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                getGenderRatioLabel(genderRate)
            }
            
            // MARK: Growth Rate
            VStack(alignment: .leading) {
                Label("Growth Rate", systemImage: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(growthRate)
            }
            
            // MARK: Base EXP Yield
            VStack(alignment: .leading) {
                Label("Base EXP Yield", systemImage: "dumbbell.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text("\(baseExpYield)")
            }
            
            // MARK: EV Yield
            VStack(alignment: .leading) {
                Label("EV Yield", systemImage: "dumbbell.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                HStack(spacing: 20) {
                    ForEach(stats, id: \.self.stat.name) { stat in
                        Text("\(getStatAbbreviation(stat.stat.name)) +\(stat.effort)")
                    }
                }
            }
            
            if isLegendary {
                // MARK: Is Legendary
                VStack(alignment: .leading) {
                    Label("Legendary", systemImage: "sparkle")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                    
                    Text("This is a legendary Pokémon!")
                }
            } else  if isMythical {
                // MARK: Is Mythical
                VStack(alignment: .leading) {
                    Label("Mythical", systemImage: "sparkles")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                    
                    Text("This is a mythical Pokémon!")
                }
            } else  if isBaby {
                // MARK: Is Baby
                VStack(alignment: .leading) {
                    Label("Baby", systemImage: "stroller.fill")
                        .foregroundStyle(accentColor)
                        .font(.headline).bold()
                    
                    Text("This is a baby Pokémon!")
                }
            }
        }
    }

    
    func getEggGroupLabel(_ eggGroup: String) -> some View {
        let title: String
        let systemImage: String
        let iconColor: Color
        
        switch eggGroup {
        case "monster":
            title = "Monster"
            systemImage = "pawprint.fill"
            iconColor = .eggGroupMonster
        case "water1":
            title = "Water 1"
            systemImage = "drop.fill"
            iconColor = .eggGroupWater1
        case "water2":
            title = "Water 2"
            systemImage = "fish.fill"
            iconColor = .eggGroupWater2
        case "water3":
            title = "Water 3"
            systemImage = "fossil.shell.fill"
            iconColor = .eggGroupWater3
        case "bug":
            title = "Bug"
            systemImage = "ladybug.fill"
            iconColor = .eggGroupBug
        case "flying":
            title = "Flying"
            systemImage = "bird.fill"
            iconColor = .eggGroupFlying
        case "ground":
            title = "Field"
            systemImage = "globe.europe.africa.fill"
            iconColor = .eggGroupField
        case "fairy":
            title = "Fairy"
            systemImage = "sparkles"
            iconColor = .eggGroupFairy
        case "plant":
            title = "Grass"
            systemImage = "leaf.fill"
            iconColor = .eggGroupGrass
        case "humanshape":
            title = "Human-Like"
            systemImage = "figure.arms.open"
            iconColor = .eggGroupHumanLike
        case "mineral":
            title = "Mineral"
            systemImage = "mountain.2.fill"
            iconColor = .eggGroupMineral
        case "indeterminate":
            title = "Amorphous"
            systemImage = "cloud.fill"
            iconColor = .eggGroupAmorphous
        case "ditto":
            title = "Ditto"
            systemImage = "questionmark.circle.fill"
            iconColor = .eggGroupDitto
        case "dragon":
            title = "Dragon"
            systemImage = "lizard.fill"
            iconColor = .eggGroupDragon
        default:
            title = "Undiscovered"
            systemImage = "x.circle.fill"
            iconColor = .eggGroupNotDiscovered
        }
        
        return Label {
            Text(title)
        } icon: {
            Image(systemName: systemImage)
                .foregroundStyle(iconColor)
        }
    }
    
    @ViewBuilder
    func getGenderRatioLabel(_ genderRate: Int) -> some View {
        if genderRate == -1 {
            Text("This pokemon has no gender...")
        } else if genderRate == -2 {
            Text("No gender information available...")
        } else {
            let femaleRate = (Float(genderRate) * 0.125) * 100
            let maleRate = 100 - femaleRate
            
            HStack(spacing: 20) {
                // Female
                Label {
                    Text("\(String(format: "%.2f", femaleRate))%")
                } icon: {
                    Image(systemName: "figure.stand.dress")
                        .foregroundStyle(.pink)
                }
                
                // Male
                Label {
                    Text("\(String(format: "%.2f", maleRate))%")
                } icon: {
                    Image(systemName: "figure.stand")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
    
    func getStatAbbreviation(_ stat: String) -> String {
        switch stat {
        case "hp":
            return "HP"
        case "attack":
            return "ATK"
        case "defense":
            return "DEF"
        case "special-attack":
            return "SpATK"
        case "special-defense":
            return "SpDEF"
        case "speed":
            return "SPD"
        default:
            return "N/A"
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
