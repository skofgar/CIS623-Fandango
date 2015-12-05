//
//  LanguageParser.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import Foundation

class LanguageParser {
    static let sharedInstance = LanguageParser()

    
    func parse(input: [String]) -> MovieDictionary {
        var results = MovieDictionary()
        
        for value in input {
            results.merge(parse(value))
        }
        return results
    }
    
    func parse(input: String) -> MovieDictionary {
        let tokens: [String] = input.componentsSeparatedByString(" ")
        var results = MovieDictionary()
        
        for token in tokens {
            results = checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByMovie(token), dic: results)
            results = checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByTheatre(token), dic: results)
            results = checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByShowTime(token), dic: results)
        }
        return results
    }
    
    func checkAndAddToDictonary(movies: [Movie]?, dic: MovieDictionary) -> MovieDictionary {
        print(movies)
        if (nil != movies) {
            return addToDictionary(movies!, dic: dic)
        }
        return dic
    }
    
    func addToDictionary(movies: [Movie], var dic: MovieDictionary) -> MovieDictionary {
        for movie in movies {
            if (nil == dic[movie.name]) {
                // TODO: currently overwriting the movie (instead of storing all alternative possibilites)
                dic[movie.name] = movie
            }
        }
        return dic
    }
}

extension Dictionary {
    mutating func merge<K, V>(dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}

typealias MovieDictionary  = Dictionary<String, Movie>