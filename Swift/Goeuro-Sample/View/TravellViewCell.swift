//
//  TravellViewCell.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 18/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit

class TravellViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lblDeparture: UILabel!
    @IBOutlet weak var lblArrival: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblChanges: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
