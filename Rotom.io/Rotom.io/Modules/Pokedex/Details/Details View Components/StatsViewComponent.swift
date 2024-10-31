//
//  StatsViewComponent.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/30/24.
//

import SwiftUI

struct StatsViewComponent: View {
    let accentColor: Color
    let stats: [PokemonStat]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .font(.title2).bold()
            
            
                ForEach(stats, id: \.self.stat.name) { stat in
                    
                    HStack {
                        Text(getStatAbbreviation(stat.stat.name)).bold()
                            .foregroundStyle(accentColor)
                            .frame(minWidth: 70, alignment: .leading)
                        Text("\(stat.baseStat)").bold()
                            .frame(minWidth: 70, alignment: .leading)
                        ProgressView(value: Float(stat.baseStat), total: 255)
                    }
                    
                    
                }
                
                HStack {
                    Text("TOT").bold()
                        .foregroundStyle(accentColor)
                        .frame(minWidth: 70, alignment: .leading)
                    Text("\(getTotalStats())").bold()
                        .frame(minWidth: 70, alignment: .leading)
                    ProgressView(value: Float(getTotalStats()), total: 255*6)
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
    
    func getTotalStats() -> Int {
        var total = 0
        //guard let stats = pokemon?.stats else { return 0 }
        for stat in stats {
            total += stat.baseStat
        }
        return total
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
