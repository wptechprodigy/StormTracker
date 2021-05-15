//
//  WeekDayTableViewCell.swift
//  StormTracker
//
//  Created by waheedCodes on 13/05/2021.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = StormTracker.Color.baseTextColor
            dayLabel.font = StormTracker.Fonts.heavyLarge
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .black
            dateLabel.font = StormTracker.Fonts.lightRegular
        }
    }
    
    @IBOutlet weak var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = StormTracker.Fonts.lightSmall
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .black
            temperatureLabel.font = StormTracker.Fonts.lightSmall
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = StormTracker.Color.baseTintColor
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    func configure(with viewModel: WeekDayViewModel) {
        dayLabel.text = viewModel.day
        dateLabel.text = viewModel.date
        iconImageView.image = viewModel.image
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
    }

}
