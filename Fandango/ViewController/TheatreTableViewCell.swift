//
//  TheatreTableViewCell.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import UIKit

class TheatreTableViewCell: UITableViewCell {

    @IBOutlet weak var theatreName: UILabel!
    @IBOutlet weak var showtimeOne: UIButton!
    @IBOutlet weak var showtimeTwo: UIButton!
    @IBOutlet weak var showtimeThree: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
