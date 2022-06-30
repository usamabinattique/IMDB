//
//  ContentView.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI
import CoreData

struct FavourtiesView: View {
    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \movie.imdbID!, ascending: true)],
//        animation: .default)
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Movie>

    var body: some View {
        NavigationView {
            
            Text("WHO LET THE DOSG OUT")
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.year)")
                    } label: {
                        Text(item.title!)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
struct FavourtiesView_Previews: PreviewProvider {
    static var previews: some View {
        FavourtiesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
