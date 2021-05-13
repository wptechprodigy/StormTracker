//
//  WeekViewController.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: WeekViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup view model
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            // tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    
    private func setupView() {
        view.backgroundColor = .systemBlue
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        print(viewModel)
    }
    
}
