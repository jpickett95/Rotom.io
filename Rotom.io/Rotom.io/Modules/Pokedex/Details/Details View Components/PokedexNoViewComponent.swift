//
//  PokedexNoComponentView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/30/24.
//

import SwiftUI

struct PokedexNoViewComponent: View {
    let regionalDexNo: Int
    let nationalDexNo: Int
    
    var body: some View {
        HStack {
            // MARK: Regional Dex #
            Text("Regional # \(regionalDexNo)")
                .foregroundStyle(.white)
                .font(.headline).bold()
                .padding([.leading, .trailing], 20)
                .padding(.vertical, 5)
                .background(Color("rotomPhone-background-orange"))
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 20,
                        topTrailingRadius: 20
                    )
                )
            
            Spacer()
            
            // MARK: National Dex #
            Text("National # \(nationalDexNo)")
                .foregroundStyle(.white)
                .font(.headline).bold()
                .padding([.leading, .trailing], 20)
                .padding(.vertical, 5)
                .background(Color("rotomPhone-background-orange"))
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )
        }
        .frame(maxWidth: .infinity)
        .offset(y: -25)
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
