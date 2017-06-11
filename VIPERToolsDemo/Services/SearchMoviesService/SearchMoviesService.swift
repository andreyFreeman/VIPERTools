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

public typealias SearchMoviesServiceResult = ServiceResult<SearchMoviesResult, SearchMoviesServiceError>
public typealias MovieDetailsServiceResult = ServiceResult<Movie, SearchMoviesServiceError>

public struct SearchMoviesResult {
    public let paging: Paging
    public let date: Date
    public let type: MovieType
    public let term: String
    public let additionalParams: [String: Any]
    public let results: [Movie]
}

public struct Movie {
    
    public struct Details {
        public let actors: String
        public let award: String
        public let country: String
        public let director: String
        public let genre: String
        public let ageRating: String
        public let rating: Float
        public let runtime: String
        public let writer: String
    }
    
    public let id: String
    public let posterUrl: String
    public let title: String
    public let type: MovieType
    public let year: String
    public let details: Details?
}

public protocol SearchMoviesService {
    func search(_ result: SearchMoviesResult, completion: @escaping (SearchMoviesServiceResult) -> Void)
    func details(forMovieWithId id: String, completion: @escaping (MovieDetailsServiceResult) -> Void)
}
