//
//  ViewModel.swift
//  APIPractice
//
//  Created by Devanshu Dev Chaudhary on 12/02/23.
//

import Foundation
import SwiftUI

@MainActor
class MovieVM: ObservableObject {
    
    @Published var moviesList: [MovieModel] = []
    
    func fetchMovies(_ query: String) async {
        moviesList = await APIManager.shared.fetchMoviesData(searchQuery: query)
    }
    
}


