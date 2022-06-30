//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: MovieDetailViewModel
    @State private var presentSheet = false

    // injecting view model
    init(imdbID: String) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(id: imdbID ))
    }
    var body: some View {
        
        VStack {
            
            if let detail = viewModel.detail {
                CircleImage(urlString: detail.poster)
                VStack(alignment: .center, spacing: 5) {
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text(detail.title).bold()
                        Text(detail.year)
                    }
                    Text(detail.plot)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text("Release Date")
                        Text(detail.released).font(Font.headline)
                    }
                    
                    HStack(spacing: 5) {
                        Text("IMDB Rating")
                        Text(detail.imdbRating)
                    }
                }
                
            } else {
                Text("No Details found").bold()
            }
            
            Spacer()
                .toolbar {
                    if viewModel.showToolbar {
                        
                        HStack {
                            Button {
                                addItem()
                            }
                            label: {
                            Image(systemName: "heart")
                            }
                            
                            Button("Share") {
                                presentSheet = true
                            }
                            .confirmationDialog("Share", isPresented: $presentSheet) {
                                Button("Email") {
                                    let url = URL(string: "message://")
                                    if let url = url {
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                                    }
                                }
                                Button("Whatsapp") {}

                            }
                        }
                    }
                }
        }
        .task {
            viewModel.fetchDetail()
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Movie(context: viewContext)
            newItem.title = viewModel.detail!.title
            newItem.year = Int16(viewModel.detail!.year)!
            newItem.poster = viewModel.detail!.poster
            newItem.imdbRating = Float(viewModel.detail!.imdbRating)!
            newItem.releaseDate = viewModel.detail!.released
            
            print(newItem)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//
//
//
//        private let items: FetchedResults<Movie>
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

struct MovieDetailView_Previews: PreviewProvider {
    static let imdbID = "tt0120338"
    static var previews: some View {
        MovieDetailView(imdbID: imdbID)
    }
}
