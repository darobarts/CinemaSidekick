//
//  MovieTableViewCell.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/16/17.
//
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
