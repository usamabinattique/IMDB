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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.title!, ascending: true)],
        animation: .default)
        private var movies: FetchedResults<Movie>

    var body: some View {
        NavigationView {
            
            List {
                ForEach(movies) { item in
                    HStack(alignment: .center, spacing: 5) {
                        URLImage(urlString: item.poster!)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.title!)
                                .bold()
                            
                    
                            HStack {
                                Text("Released").font(.caption)
                                Text(item.releaseDate!).font(.footnote)
                            }
                            
                            HStack {
                                Text("IMDB Rating").font(.caption)
                                Text(String(format: "%.1f/10", item.imdbRating)).font(.footnote)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }.onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { movies[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct FavourtiesView_Previews: PreviewProvider {
    static var previews: some View {
        FavourtiesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
