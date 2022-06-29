//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    
    // injecting view model
    init(imdbID: String) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(id: imdbID ))
    }
    var body: some View {
        onAppear {
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
