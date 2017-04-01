//
//  ScoreboardTableViewCell.swift
//  CustomIronPongViews
//
//  Created by Jonathan Edgar on 3/31/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class ScoreboardTableViewCell: UITableViewCell {

    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
