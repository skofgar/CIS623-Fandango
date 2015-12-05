//
//  Movie.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import Foundation

struct Movie {
    let name: String
    let showtime: String
    let theatre: String
    
    init(name: String, theatre: String, showtime: String) {
        self.name = name
        self.theatre = theatre
        self.showtime = showtime
    }
}