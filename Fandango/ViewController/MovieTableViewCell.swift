//
//  MovieTableViewCell.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var theatreTableView: UITableView!
    @IBOutlet weak var theatreOneName: UILabel!
    @IBOutlet weak var theatreOneShowtimeOne: UIButton!
    @IBOutlet weak var theatreOneShowtimeTwo: UIButton!
    @IBOutlet weak var theatreOneShowtimeThree: UIButton!
    
    private var data: Set<Movie>?
    private var moviesByTheatreSet: MovieDictionarySet?
    private var theatres: [String] = []
    var movies: Set<Movie> {
        get {
            return (nil == data) ? Set<Movie>() : data!
        }
        set(updatedMovieList) {
            self.data = updatedMovieList
            self.moviesByTheatreSet = organizeByTheatre(self.data!)
            self.theatreTableView.reloadData()
        }
    }
    
    func organizeByTheatre(input: Set<Movie>) -> MovieDictionarySet {
        var dic = Dictionary<String, Set<Movie>>()
        for movie in input {
            if (nil == dic[movie.theatre]) {
                dic[movie.theatre] = Set<Movie>()
            }
            dic[movie.theatre]?.insert(movie)
        }
        
        self.theatres = [String] (dic.keys)
        return dic
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.theatreTableView.dataSource = self
        self.theatreTableView.delegate = self
        self.theatreTableView.separatorColor = UIColor.clearColor();
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.theatres.count //(nil == self.data) ? 0 : self.data!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("theatreCell", forIndexPath: indexPath)
        
        if (nil != self.moviesByTheatreSet && cell is TheatreTableViewCell) {
            let theatreCell = cell as! TheatreTableViewCell
            let movies = self.moviesByTheatreSet![self.theatres[indexPath.row]]!
            theatreCell.theatreName.text = movies.first?.theatre.localizedUppercaseString
            
            let sortedMovies = movies.sort(before)
            theatreCell.showtimeOne.setImage(UIImage(named: sortedMovies[0].showtime), forState: .Normal)
            if (sortedMovies.count > 1) {
                theatreCell.showtimeTwo.setImage(UIImage(named: sortedMovies[1].showtime), forState: .Normal)
                theatreCell.showtimeTwo.hidden = false
            } else {
                theatreCell.showtimeTwo.hidden = true
            }
            if (sortedMovies.count > 2) {
                theatreCell.showtimeThree.setImage(UIImage(named: sortedMovies[2].showtime), forState: .Normal)
                                theatreCell.showtimeThree.hidden = false
            } else {
                theatreCell.showtimeThree.hidden = true
            }
            
            //            let movieCell = cell as! MovieTableViewCell
//            let allMoviesSet = self.data?.values
//            let movieSet = allMoviesSet![self.data!.startIndex.advancedBy(indexPath.row)]
//            let movie = movieSet[movieSet.startIndex]
//            movieCell.movieTitle.text = movie.name.localizedUppercaseString
//            
            cell = theatreCell
        }
        return cell
    }

    func before(movieA: Movie, movieB: Movie) -> Bool {
        return movieA.name < movieB.name
    }
}
