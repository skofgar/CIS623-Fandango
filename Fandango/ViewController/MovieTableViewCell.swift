//
//  MovieTableViewCell.swift
//  Fandango
//
//  Created by Roland on 05/12/15.
//  Copyright © 2015 CFR. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var theatreOneName: UILabel!
    @IBOutlet weak var theatreOneShowtimeOne: UIButton!
    @IBOutlet weak var theatreOneShowtimeTwo: UIButton!
    @IBOutlet weak var theatreOneShowtimeThree: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var movieName: String {
        get {
            return movieTitle.text!
        }
        set(movieName) {
            movieTitle.text = movieName
        }
    }
    
}
