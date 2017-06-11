//
//  SearchMoviesService.swift
//  Services
//
//  Created by ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

public enum MovieType: String {
    case movie   = "movie"
    case series  = "series"
    case episode = "episode"
}

public enum SearchMoviesServiceError: Error {
    case unknownError
}

public enum SearchMoviesServiceResult<T> {
    case success(T)
    case failed(SearchMoviesServiceError)
}

public struct SearchMoviesResult {
    
}

public struct Movie {
    
}

public protocol SearchMoviesService {
    func search(withSearchTerm term: String, type: MovieType?, page: Int, completion: @escaping (MoviesAPIResult<SearchMoviesResult>) -> Void)
    func loadDetails(forMovieWithId id: String, completion: @escaping (MoviesAPIResult<SearchMoviesResult>) -> Void)
}
