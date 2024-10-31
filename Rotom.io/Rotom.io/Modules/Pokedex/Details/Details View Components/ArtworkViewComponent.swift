//
//  ArtworkComponentView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/30/24.
//

import SwiftUI

struct ArtworkViewComponent: View {
    // MARK: Properties
    @Binding var showShinyArtwork: Bool
    let shinyArtwork: Data?
    let officialArtwork: Data?
    let type1Color: Color
    let type2Color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Picker
            Picker("Artwork", selection: $showShinyArtwork) {
                Text("Regular").tag(false)
                Text("Shiny").tag(true)
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 5)
            .frame(maxWidth: 150)
            
            // MARK: Image
            VStack(alignment: .leading) {
                if let imageData = showShinyArtwork ? shinyArtwork : officialArtwork, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 20)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.vertical, 30)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(LinearGradient(colors: [type1Color, .white, type2Color], startPoint: .topLeading, endPoint: .bottomTrailing))
            .border(Color("rotomPhone-background-orange"), width: 3)
        }
        .background(Color("rotomPhone-background-orange"))
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
