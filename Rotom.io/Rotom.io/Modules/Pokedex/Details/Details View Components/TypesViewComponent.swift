//
//  TypesViewComponent.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/30/24.
//

import SwiftUI

struct TypesViewComponent: View {
    @ObservedObject var vm: PokemonDetailsViewModel
    let types: [SpeciesType]
    
    var body: some View {
        HStack(spacing: 15) {
            Spacer()
            ForEach(types, id: \.self.slot) { type in
                HStack(spacing: 5) {
                    Image("\(type.type.name.capitalized)_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text(type.type.name.capitalized)
                        .font(.subheadline).bold()
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 5)
                .padding([.leading, .trailing], 8)
                .background(Color(vm.getTypeColor(type.type.name).rawValue))
                .clipShape(.capsule)
                
            }
            Spacer()
        }
        .frame(maxHeight:30)
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
