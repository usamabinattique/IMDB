//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

struct MovieDetailView: View {

    @StateObject private var viewModel: MovieDetailViewModel
    @State private var presentSheet = false
    @State var isFavorited : Bool = false


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
                ProgressView().padding()
            }
            
            Spacer()
                .toolbar {
                    if viewModel.showToolbar {
                        
                        HStack {
                            Button {
                                self.isFavorited.toggle()
                                isFavorited ? viewModel.addItem() : viewModel.deleteItem()
                            }
                            label: {
                                Image(systemName: isFavorited ? "heart.fill" : "heart")
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
        .navigationBarTitleDisplayMode(.inline)
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
