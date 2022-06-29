//
//  MovieDetailViewModel.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import Foundation

class MovieDetailViewModel: ObservableObject {

    @Published var detail: MovieDetail!
    var imdbID: String!
    
    init(id: String) {
        self.imdbID = id
    }

    func fetchDetail() {

        let base: String = "https://www.omdbapi.com/"

        let queryString: [String: String] = ["apikey": Constants.apiKey,
                                             "i": imdbID]

        let endpoint = Endpoint<MovieDetail>(json: .get, url: URL(string: base)!, query: queryString)

        URLSession.shared.load(endpoint) { result in
          switch result {
          case let .success(detail):
              DispatchQueue.main.async {
                  self.detail = detail
              }
          case let .failure(error):
              DispatchQueue.main.async {
                  
              }
          }
        }
    }
}
