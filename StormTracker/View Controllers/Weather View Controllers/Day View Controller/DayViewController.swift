//
//  DayViewController.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

final class DayViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = StormTracker.Color.baseTextColor
            dateLabel.font = StormTracker.Fonts.heavyLarge
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = StormTracker.Color.baseTintColor
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = StormTracker.Fonts.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = StormTracker.Fonts.lightSmall
            }
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    @IBOutlet var weatherDataView: [UIView]! {
        didSet {
            for view in weatherDataView {
                view.isHidden = true
            }
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        setupView()
    }
    
    // MARK: - Helper Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = StormTracker.Color.lightBackgroundColor
    }
    
    private func setupViewModel(with viewModel: DayViewModel) {
        activityIndicatorView.stopAnimating()
        
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
        windSpeedLabel.text = viewModel.windSpeed
        descriptionLabel.text = viewModel.summary
        
        iconImageView.image = viewModel.image
        
        for view in weatherDataView {
            view.isHidden = false
        }
    }
    
}
