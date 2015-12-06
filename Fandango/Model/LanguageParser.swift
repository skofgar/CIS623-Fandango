//
//  LanguageParser.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import Foundation

class LanguageParser {
    static let sharedInstance = LanguageParser()

    
    func parse(input: [String]) -> MovieDictionarySet {
        var results = MovieDictionarySet()
        
        for value in input {
            let dictionary = parse(value)
            results = self.merge(results, dictionaryB: dictionary)
        }
        return results
    }
    
    func parse(input: String) -> MovieDictionarySet {
        let tokens: [String] = input.componentsSeparatedByString(" ")
        var results = MovieDictionarySet()
        
        for token in tokens {
            checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByMovie(token), dic: &results)
            checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByTheatre(token), dic: &results)
            checkAndAddToDictonary(MovieCollection.sharedInstance.lookupByShowTime(token), dic: &results)
        }
        return results
    }
    
    func checkAndAddToDictonary(movies: [Movie]?, inout dic: MovieDictionarySet) {
        if (nil != movies) {
            addToDictionary(movies!, dic: &dic)
        }
    }
    
    func addToDictionary(movies: [Movie], inout dic: MovieDictionarySet)  {
        for movie in movies {
            if (nil == dic[movie.name]) {
                dic[movie.name] = Set<Movie>()
                dic[movie.name]?.insert(movie)
            } else {
                if (false == dic[movie.name]!.contains(movie)) {
                    dic[movie.name]?.insert(movie)
                }
            }
        }
    }
    
    func merge(dictionaryA: MovieDictionarySet, dictionaryB: MovieDictionarySet) -> MovieDictionarySet {
        var result = MovieDictionarySet()
        for (k, v) in dictionaryA {
            result.updateValue(v, forKey: k)
        }
        
        for (k, v) in dictionaryB {
            if (nil == result[k]) {
                result.updateValue(v, forKey: k)
            } else {
                result[k] = result[k]?.union(v)
            }
        }
        
        return result
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
typealias MovieDictionarySet = Dictionary<String, Set<Movie>>