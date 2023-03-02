//
//  Model.swift
//  APIPractice
//
//  Created by Devanshu Dev Chaudhary on 12/02/23.
//

import Foundation

struct MovieModel: Decodable {
    
    var uid: UUID
    var title: String
    var year: String
    var rated: String
    var released: Date
    var director: String
    var plot: String
    var language: String
    var poster: URL?
    var ratings: [RatingsModel] = []
    
    init(_ data: [String : Any]) {
        
        uid = UUID()
        
        title = data["Title"] as? String ?? ""
        year = data["Year"] as? String ?? ""
        rated = data["Rated"] as? String ?? ""
        
        let dateReleased = data["Released"] as? String ?? ""
        released = Date().dateString(dateReleased) ?? .now

        director = data["Director"] as? String ?? ""
        plot = data["Plot"] as? String ?? ""
        language = data["Language"] as? String ?? ""
        
        let posterUrl = data["Poster"] as? String ?? ""
        poster = URL(string: posterUrl)
        
        let ratingsData = data["Ratings"] as? [[String:Any]] ?? []
        
        for rating in ratingsData {
            let fetchedRating = RatingsModel(rating)
            ratings.append(fetchedRating)
        }
    }
}
