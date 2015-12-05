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
        ,("Incredibles","North","8")
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
        let test = moviesByName["name"]
        print(test)
        
        for movie in movies {
            let data = Movie(name: movie.name.lowercaseString, theatre: movie.theatre.lowercaseString, showtime: movie.showtime.lowercaseString)
            
            addMovie(data, toDictionary: &moviesByName)
            addMovie(data, toDictionary: &moviesByTime)
            addMovie(data, toDictionary: &moviesByTheatre)
        }
    }
    
    private func addMovie(movie: Movie, inout toDictionary: Dictionary<String, [Movie]>) {
        if (nil == moviesByName[movie.name]) {
            toDictionary[movie.name] = [movie]
        } else {
            toDictionary[movie.name]?.append(movie)
        }
    }
    
    func lookupByMovie(name: String) -> [Movie]? {
        print(self.moviesByName[name.lowercaseString])
        return self.moviesByName[name.lowercaseString]
    }
    
    func lookupByShowTime(showTime: String) -> [Movie]? {
        return self.moviesByTime[showTime.lowercaseString]
    }
    
    func lookupByTheatre(name: String) -> [Movie]? {
        return self.moviesByTheatre[name.lowercaseString]
    }
}