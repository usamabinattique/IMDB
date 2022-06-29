//
//  ViewModel.swift
//  IMDB
//
//  Created by Usama on 28/06/2022.
//

import SwiftUI

class ViewModel: ObservableObject {

    @Published var responseType: ResponseType!
    @Published var movieTitle: String = ""

    func fetch() {

        let base: String = "https://www.omdbapi.com/"

        let queryString: [String: String] = ["apikey": Constants.apiKey,
                                             "s": movieTitle]

        let endpoint =  Endpoint<ResponseType>(json: .get, url: URL(string: base)!, query: queryString)

        URLSession.shared.load(endpoint) { result in
          switch result {
          case let .success(decodingType):
              DispatchQueue.main.async {
                  self.responseType = decodingType
              }
          case let .failure(error):
              DispatchQueue.main.async {
                  self.responseType = .error(ResponseError(Response: "Error", Error: error.localizedDescription))
              }
          }
        }
    }
}
