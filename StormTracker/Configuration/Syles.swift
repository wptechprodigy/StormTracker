//
//  Syles.swift
//  StormTracker
//
//  Created by waheedCodes on 11/05/2021.
//

import UIKit

extension UIColor {
    
    enum StormTracker {
        private static let base: UIColor = UIColor(red: 0.31,
                                                green: 0.72,
                                                blue: 0.83,
                                                alpha: 1.0
        )
        
        static var baseTextColor: UIColor {
            return base
        }
        
    }
}

extension UIFont {
    
    enum StormTracker {
        
        static let lightSmall: UIFont = .systemFont(ofSize: 15, weight: .light)
        static let lightRegular: UIFont = .systemFont(ofSize: 17, weight: .light)
        static let heavyLarge: UIFont = .systemFont(ofSize: 20, weight: .heavy)
        
    }
    
}
