//
//  ContentView.swift
//  IMDB
//
//  Created by Usama on 28/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    let fruits = ["adsf", "akdhf"]
    
    @State var searching = false

    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                SearchBar(searchText: $viewModel.movieTitle,
                          searching: $searching, viewModel: viewModel)
                ResultView(viewModel: .constant(viewModel), searching: $searching)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom:0 , trailing: 0))
                    .layoutPriority(1)
                Spacer()
                
                .navigationTitle(searching ? "Searching" : "Movies")

                //                 adding cancel button to the navigation bar
                .toolbar {
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if searching {
                            Button("Cancel") {
                                viewModel.movieTitle = ""
                                withAnimation {
                                    searching = false
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }
                        }
                        
                        NavigationLink(destination: FavourtiesView()) {
                            Image(systemName: "suit.heart.fill")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ResultView: View {
    
    @Binding var viewModel: ViewModel
    @Binding var searching: Bool
    @State var selectedItem: MovieID? = nil 
    
    @State var isActive: Bool? = nil
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        switch viewModel.responseType  {
            
        case let .list(items):
            List(items.search, id: \.self, selection: $selectedItem) { item in
                
                NavigationLink(destination: MovieDetailView(imdbID: item.imdbID).environment(\.managedObjectContext, persistenceController.container.viewContext)) {
                    HStack(alignment: .center, spacing: 10) {
                        URLImage(urlString: item.poster)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.title)
                                .bold()
                            Text(item.year)
                        }
                    }
                }
            }
            
        case let .detail(detail):
            ProgressView()
            
        case let .error(error):
            ZStack {
                Text(error.Error)
            }
        case .unknown:
            ProgressView()
        case .none:
            ProgressView()
        }
    }
}
