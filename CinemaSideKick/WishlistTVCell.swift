//
//  WishlistTVCell.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 5/16/17.
//
//

import UIKit

class WishlistTVCell: UITableViewCell {
    
    //outlets to the custom table cell components
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



