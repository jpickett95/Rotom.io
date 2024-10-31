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
    let height: Float
    let weight: Float
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Characteristics")
                .font(.title2).bold()
            
            // MARK: Name
            VStack {
                Label("Name", systemImage: "person.text.rectangle.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(name)
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
                
                Text(String(format: "%.1f", height) + " m")
            }
            
            // MARK: Weight
            VStack(alignment: .leading) {
                Label("Weight", systemImage: "scalemass.fill")
                    .foregroundStyle(accentColor)
                    .font(.headline).bold()
                
                Text(String(format: "%.1f", weight) + " kg")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
