//
//  MovieDetailViewModel.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import Foundation
import CoreData

class MovieDetailViewModel: ObservableObject {

    @Published var detail: MovieDetail?
    @Published var showToolbar: Bool = false
    
    let viewContext = PersistenceController.shared.container.viewContext

    var imdbID: String!
    
    init(id: String) {
        self.imdbID = id
    }

    func fetchDetail() {


        let queryString: [String: String] = ["apikey": Constants.apiKey,
                                             "i": imdbID]

        let endpoint = Endpoint<MovieDetail>(json: .get, url: URL(string: Constants.base)!, query: queryString)

        URLSession.shared.load(endpoint) { result in
          switch result {
          case let .success(detail):
              DispatchQueue.main.async {
                  self.showToolbar = true
                  self.detail = detail
              }
          case let .failure(error):
              DispatchQueue.main.async {
                 print("error")
              }
          }
        }
    }
    
    
    func addItem() {
            let newItem = Movie(context: viewContext)
            newItem.title = detail!.title
            newItem.year = Int16(detail!.year)!
            newItem.poster = detail!.poster
            newItem.imdbRating = Float(detail!.imdbRating)!
            newItem.plot = detail!.plot
            newItem.imdbID = detail!.imdbID
            newItem.releaseDate = detail!.released
            
            print(newItem)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
    
    
    func deleteItem() {
        
        let movieRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        movieRequest.predicate = NSPredicate.init(format: "imdbID=%@", detail!.imdbID)
        
        do {
            
            let savedMovie = try  self.viewContext.fetch(movieRequest)
            
            for movie in savedMovie {
                self.viewContext.delete(movie)
            }
            
            try viewContext.save()
        } catch {
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

