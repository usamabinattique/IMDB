//
//  Endpoints.swift
//  IMDB
//
//  Created by Usama on 28/06/2022.
//

import Foundation


enum API {

    private static let base: String = "http://www.omdbapi.com/"
    
    static func getMovies() -> Endpoint<ResponseType> {
        let queryString: [String: String] = ["apiKey": Constants.apiKey]
        return Endpoint(json: .get, url: URL(string: self.base)!, query: queryString)
    }
}
