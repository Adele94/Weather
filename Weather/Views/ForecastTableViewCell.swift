//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by  Adele Shavalieva on 13/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var forecastImageView: UIImageView!
    @IBOutlet var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
