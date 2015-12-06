//
//  MovieCollection.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import Foundation

class MovieCollection {
    static let sharedInstance = MovieCollection()

    var moviesByName = Dictionary<String, [Movie]>()
    var moviesByTime = Dictionary<String, [Movie]>()
    var moviesByTheatre = Dictionary<String, [Movie]>()
    
    let movies: [(name: String, theatre: String, showtime: String)] = [
        ("Incredibles","Woodland","7")
        ,("Incredibles","Woodland","8")
        ,("Incredibles","North","8")
        ,("Incredibles","North","9")
        ,("Incredibles","Rivertown","7")
        ,("Spectre","North","7")
        ,("Spectre","Rivertown","7")
        ,("Spectre","AMC","8")
        ,("Amelie","Woodland","6")
        ,("Spongebob","Rivertown","7")
        ,("Goldeneye","Woodland","7")
        ,("Goldeneye","Woodland","10")
        ,("Spongebob","AMC","8")
    ];
    
    private init() {
        setupMovies()
    }
    
    private func setupMovies() {
        for movie in movies {
            let data = Movie(name: movie.name.lowercaseString, theatre: movie.theatre.lowercaseString, showtime: movie.showtime.lowercaseString)
            
            addMovie(data, key: data.name, toDictionary: &moviesByName)
            addMovie(data, key: data.showtime, toDictionary: &moviesByTime)
            addMovie(data, key: data.theatre, toDictionary: &moviesByTheatre)
        }
    }
    
    private func addMovie(movie: Movie, key: String, inout toDictionary: Dictionary<String, [Movie]>) {
        if (nil == toDictionary[key]) {
            toDictionary[key] = [movie]
        } else {
            toDictionary[key]?.append(movie)
        }
    }
    
    func lookupByMovie(name: String) -> [Movie]? {
        return self.moviesByName[name.lowercaseString]
    }
    
    func lookupByShowTime(showTime: String) -> [Movie]? {
        return self.moviesByTime[showTime.lowercaseString]
    }
    
    func lookupByTheatre(name: String) -> [Movie]? {
        return self.moviesByTheatre[name.lowercaseString]
    }
}