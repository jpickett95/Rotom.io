//
//  GenerationIcon.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI

struct GenerationIcon: View {
    var body: some View {
        
        ZStack {
            Image(systemName: "circle.lefthalf.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.red, .yellow, .blue)
            HStack(spacing: 3) {
                Image("red-blue-yellow")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red, .blue, .yellow)
                
                Divider()
                    .overlay(.tertiary)
                    .padding(0)
                
                Image(systemName: "moon.fill")
                    .resizable()
                    .scaledToFit()
            }.frame(width: 30, height: 30)
            
//            Image("Pokeball")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 30)
        }
        .preferredColorScheme(.light)
        .frame(width: 40, height: 40)
        .background(
            
//            LinearGradient(colors: [.red, .yellow, .blue], startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(Circle())
    }
}

#Preview {
    GenerationIcon()
}
