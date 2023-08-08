//
//  DetailTableViewCell.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var player1Name: UILabel!
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var player2name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
