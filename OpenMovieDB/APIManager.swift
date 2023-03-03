//
//  APIManager.swift
//  APIPractice
//
//  Created by devdchaudhary on 12/02/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func fetchMoviesData(searchQuery: String) async -> MovieModel {
        
        guard let url = URL(string: "http://www.omdbapi.com/?t=\(searchQuery)&apiKey=\(Constants.token)") else { return MovieModel([:]) }
        
        let request = URLRequest(url: url)
        
        do {
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return MovieModel([:])
            }
            
            return MovieModel(json)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return MovieModel([:])
    }
}
