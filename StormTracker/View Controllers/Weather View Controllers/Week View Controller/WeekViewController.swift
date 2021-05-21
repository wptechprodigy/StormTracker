//
//  WeekViewController.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

protocol WeekViewControllerDelegate: AnyObject {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewModel? {
        didSet {
            refreshControl.endRefreshing()
            
            if let viewModel = viewModel {
                // Setup view model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    // MARK: -
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
            
            tableView.refreshControl = refreshControl
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = StormTracker.Color.baseTintColor
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        activityIndicatorView.stopAnimating()
        
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(self)
    }
    
}

extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WeekDayTableViewCell.reuseIdentifier,
                for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to deque week day table view cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No view model present")
        }
        
        // Configure the cell
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        
        return cell
    }
}
