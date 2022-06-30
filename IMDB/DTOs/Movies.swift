//
//  Movie.swift
//  IMDB
//
//  Created by Usama on 28/06/2022.
//


import Foundation
import UIKit
import SwiftUI


enum ResponseType: Decodable {
    
    case list(MovieList)
    case error(ResponseError)
    case detail(MovieDetail)
    case unknown
    
    enum CodingKeys: String, CodingKey {
        case released
        case Error
        case totalResults
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let detail = try? container.decodeIfPresent(String.self, forKey: .released)
        let error = try? container.decodeIfPresent(String.self, forKey: .Error)
        let list = try? container.decodeIfPresent(String.self, forKey: .totalResults)
        
        let decodingContainer = try decoder.singleValueContainer()
        
        if !detail.isNilOrEmpty {
            let detail = try decodingContainer.decode(MovieDetail.self)
            self = .detail(detail)
            return

        }
        
        if !list.isNilOrEmpty {
            let list = try decodingContainer.decode(MovieList.self)
            self = .list(list)
            return
        }
        
        if !error.isNilOrEmpty {
            let error = try decodingContainer.decode(ResponseError.self)
            self = .error(error)
            return
        }
        
        self = .unknown
    }
}

struct ResponseError: Codable {
    let Response, Error: String
}

// MARK: - Movie
public struct MovieDetail: Hashable, Codable {
    
    public static var fileName: String { "MovieDetail" }

    public let title, year, rated, released: String
    public let runtime, genre, director, writer: String
    public let actors, plot, language, country: String
    public let awards, poster: String
    public let ratings: [MovieRating]?
    public let metascore, imdbRating, imdbVotes, imdbID: String
    public let type, dvd, boxOffice, production: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
    }
}



public struct MovieRating: Codable, Hashable {
    
    let source, value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
        
    }
}


// MARK: - Movie List
public struct MovieList: Codable, Hashable {
    
    let search: [MovieID]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
public struct MovieID: Codable, Hashable {

    let title, year, imdbID, type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

