//
//  RootViewController.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
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
            dayViewController.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: Layout.DayView.height),
            
            weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor),
            weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (data, error) in
            if let _ = error {
                self?.presentAlert(of: .noWeatherDataAvailable)
            } else if let data = data {
                DispatchQueue.main.async {
                    print(data)
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
        }
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

extension RootViewController {
    
    fileprivate enum Layout {
        enum DayView {
            static let height: CGFloat = 200.0
        }
    }
}
