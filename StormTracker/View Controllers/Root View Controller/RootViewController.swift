//
//  RootViewController.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }

            setupViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.storyboardIdentifier) as? DayViewController else {
            fatalError("Unable to Instantiate Day View Controller")
        }
        
        // Configure day view controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return dayViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Day View Controller")
        }
        
        // Configure day view controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return weekViewController
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
        
    }
    
    // MARK: - Helper Methods
    
    private func setupChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        layoutChildViews()
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func layoutChildViews() {
        NSLayoutConstraint.activate([
            dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor),
            weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (weatherData, error) in
            if let error = error {
                let alertType: AlertType
                
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                // Notify user
                self?.presentAlert(of: alertType)
            } else if let weatherData = weatherData as? DarkSkyResponse {
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                DispatchQueue.main.async {
                    self?.dayViewController.viewModel = dayViewModel
                    self?.weekViewController.viewModel = weekViewModel
                }
            } else {
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to Fetch Weather Data"
            message = "The application is unable to fetch weather data. Please make sure your device is conected to the internet"
        case .notAuthorizedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "StormTracker is not authorized to access your current location. This means it's unable to show you the weather for your current location. You can grant StormTracker access to your current location in the application Settings."
        }
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
