//
//  WeekDayRepresentable.swift
//  StormTracker
//
//  Created by waheedCodes on 16/05/2021.
//

import UIKit

protocol WeekDayRepresentable {
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
}
