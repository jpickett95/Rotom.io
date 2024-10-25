//
//  PokemonDetailsView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject private var vm: PokemonDetailsViewModel
    
    init(viewModel: PokemonDetailsViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageData = vm.officialArtwork, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 10)
                } else {
                   ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(LinearGradient(colors: [.green, .white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            HStack {
                Text("#\(vm.pokemonEntry.entryNumber)")
                    .foregroundStyle(.white)
                    .font(.headline).bold()
                    .padding(.leading, 20)
                    .padding(.vertical, 5)
                    
                    
                Spacer()
            }
            .frame(maxWidth: 150)
            .background(Color("rotomPhone-background-orange"))
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 20,
                    topTrailingRadius: 20
                )
                
            )
            .offset(y: -20)
            
            Button {
                coordinator.navigateToPokedex()
            } label: {
                Text("Home")
            }
            
            Spacer()
        }
    }
        
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
