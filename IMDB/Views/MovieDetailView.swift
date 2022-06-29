//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @State var showToolBarControls = false
    
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
                
                HStack(alignment: .center, spacing: 5) {
                    Text("Release Date")
                    Text(detail.released)
                }
                
            } else {
                Text("No Details found").bold()
            }
            
            Spacer()
                .navigationTitle(viewModel.detail.isNil ? "Detail" : viewModel.detail!.title)
                .toolbar {
                    if viewModel.showToolbar {
                        Button("Share") { }
                        .confirmationDialog("Share", isPresented: $viewModel.showToolbar) {
                        Button("Email") {}
                        Button("Whatsapp") {}
                        
                        }

                    }
                }
        }
        .task {
            viewModel.fetchDetail()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static let imdbID = "tt0120338"
    static var previews: some View {
        MovieDetailView(imdbID: imdbID)
    }
}


//
//Button("Share") { }
//label:{
//Label("Edit", systemImage: "pencil")
//}
//.confirmationDialog("Share", isPresented: $viewModel.showToolbar) {
//Button("Red") {}
//
//Button("Green") { }
//
//Button("Blue") { }
//}
