//
//  APIManager.swift
//  APIPractice
//
//  Created by Devanshu Dev Chaudhary on 12/02/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func fetchMoviesData(searchQuery: String) async -> [MovieModel] {
        
        let url = URL(string: "http://www.omdbapi.com/?t=\(searchQuery)&apiKey=\(Constants.token)")
        var movies: [MovieModel] = []
        
        if let url {
            
            let request = URLRequest(url: url)
            
            do {
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                    return []
                }
                
                movies = [MovieModel(json)]
            }
            catch {
                return []
            }
        }
        
        return movies
    }
}
