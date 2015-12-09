//
//  Movie.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import Foundation

struct Movie : Hashable {
    let name: String
    let showtime: String
    let theatre: String
    
    var hashValue: Int {
        return name.hashValue ^ showtime.hashValue ^ theatre.hashValue
    }
    
    init(name: String, theatre: String, showtime: String) {
        self.name = name
        self.theatre = theatre
        self.showtime = showtime
    }
}

func ==(left: Movie, right: Movie) -> Bool {
    return left.name == right.name && left.showtime == right.showtime && left.theatre == right.theatre
}