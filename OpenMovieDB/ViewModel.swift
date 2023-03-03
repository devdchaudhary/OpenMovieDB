//
//  ViewModel.swift
//  APIPractice
//
//  Created by devdchaudhary on 12/02/23.
//

import Foundation
import SwiftUI

@MainActor
class MovieVM: ObservableObject {
    
    @Published var moviesList: [MovieModel] = []
    
    func fetchMovies(_ query: String) async {
        
        let movie = await APIManager.shared.fetchMoviesData(searchQuery: query)
        
        withAnimation {
            moviesList.append(movie)
        }
        
    }
    
}


