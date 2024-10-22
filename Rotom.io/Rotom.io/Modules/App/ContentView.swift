//
//  ContentView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: Properties
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    @EnvironmentObject var settings: Settings
    @State var showingSheet = false
    @State var selectedGame: Game? = Game.national

    // MARK: Body
    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        
        NavigationStack {
            
            ScrollView {
                Text(settings.game.name)
                
                // MARK: Pokedex
                NavigationLink(destination: {
                    CustomNavigationStack(showingSheet: showingSheet) {
                        Text("Pokedex")
                    } contentView: {
                        PokedexView(viewModel: PokedexViewModel(networkManager: NetworkManager(), settings: settings))
                    }
                }, label: {
                    Text("Pokedex")
                })
            }
            //.navigationTitle("Rotom.io")
            //.navigationBarTitleDisplayMode(.large)
            .toolbar {
                // MARK: Navigation Title
                ToolbarItem(placement: .topBarLeading) {
                    Text("Rotom.io")
                        .font(.title).bold()
                }
                
                // MARK: Selected Game
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "circle")
                    }
                    .sheet(isPresented: $showingSheet) {
                        GameSheetView()
                    }
                }
                
                
                
            }
            
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

// MARK: Preview
#Preview {
    ContentView()
        .environmentObject(Settings())
    //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
