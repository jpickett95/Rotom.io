//
//  WeaknessesViewComponent.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/2/24.
//

import SwiftUI

struct WeaknessesViewComponent: View {
    @ObservedObject var vm: PokemonDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // MARK: Title
            Text("Weaknesses")
                .font(.title2).bold()
            
            // MARK: Double Damage
            if !vm.damageRelations.filter( {$1 == 2}).map({$0.key}).isEmpty {
                
                HStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(.tertiary.opacity(0.5))
                            .frame(width: 30)
                        
                        Text("2")
                            .bold()
                            .foregroundStyle(.red)
                            .frame(width: 25)
                    }
                    
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 25), spacing: 15)], spacing: 15) {
                        
                        let types = vm.damageRelations.filter( {$1 == 2}).map {$0.key}
                        
                        ForEach(types, id: \.self) { type in
                            ZStack {
                                Circle()
                                    .fill(Color(vm.getTypeColor(type).rawValue))
                                
                                Image("\(type.capitalized)_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                            }
                        }
                        
                    }
                }
            }
            
            // MARK: Quadruple Damage
            if !vm.damageRelations.filter( {$1 == 4}).map({$0.key}).isEmpty {
                
                HStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(.tertiary.opacity(0.5))
                            .frame(width: 30)
                        
                        Text("4")
                            .bold()
                            .foregroundStyle(.purple)
                            .frame(width: 25)
                    }
                    
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 25), spacing: 15)], spacing: 15) {
                        
                        let types = vm.damageRelations.filter( {$1 == 4}).map {$0.key}
                        
                        ForEach(types, id: \.self) { type in
                            ZStack {
                                Circle()
                                    .fill(Color(vm.getTypeColor(type).rawValue))
                                
                                Image("\(type.capitalized)_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
