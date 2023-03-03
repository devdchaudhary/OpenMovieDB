//
//  ContentView.swift
//  OpenMovieDB
//
//  Created by devdchaudhary on 14/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var moviesVM = MovieVM()
    
    @State private var searchQuery: String = ""
    
    let moviesArr = ["fast", "avatar", "trainspotting", "bumblebee", "aliens", "titanic", "spider-man"]
    
    init() {
        UIRefreshControl.appearance().tintColor = .systemTeal
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                TextField("Search", text: $searchQuery)
                    .submitLabel(.search)
                    .onSubmit {
                        searchClicked(searchQuery)
                        hideKeyboard()
                    }
                    .onChange(of: searchQuery) { query in
                        
                        
                    }
                
                Spacer()
                
                Button(action: {
                    searchClicked(searchQuery)
                }) {
                    Image(systemName: "magnifyingglass").foregroundColor(.black)
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color(uiColor: .systemGray5))
            .cornerRadius(30)
            
        }
        .padding()
        
        List(moviesVM.moviesList.reversed(), id: \.uid) { movie in
            
            VStack(alignment: .leading) {
                
                Text(movie.title)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.vertical, 5)
                
                if let url = movie.poster {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .cornerRadius(20)
                    .clipped()
                }
                
                Text(movie.plot)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text("Ratings")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.vertical, 10)
                
                ForEach(movie.ratings, id: \.uid) { rating in
                    
                    HStack {
                        
                        Text(rating.source)
                            .padding(.vertical, 10)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text(rating.value)
                            .padding(.vertical, 10)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                    }
                }
            }
        }
        .listStyle(.inset)
        .listRowSeparator(.hidden)
        .task {
            await moviesVM.fetchMovies(moviesArr.randomElement() ?? "man of the earth")
        }
        .refreshable {
            await moviesVM.fetchMovies(moviesArr.randomElement() ?? "man of the earth")
        }
    }
    
    private func searchClicked(_ query: String) {
        Task {
            await moviesVM.fetchMovies(query)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
