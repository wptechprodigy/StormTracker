//
//  Syles.swift
//  StormTracker
//
//  Created by waheedCodes on 11/05/2021.
//

import UIKit

enum StormTracker {
    
    enum Color {
        private static let baseColor: UIColor = UIColor(red: 0.31,
                                                green: 0.72,
                                                blue: 0.83,
                                                alpha: 1.0
        )
        
        static var baseTextColor: UIColor {
            return baseColor
        }
        
        static var baseTintColor: UIColor {
            return baseColor
        }
        
        static var baseBackgroundColor: UIColor {
            return baseColor
        }
        
        static var lightBackgroundColor: UIColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1.0)
    
    }
    
    enum Fonts {
        
        static let lightSmall: UIFont = .systemFont(ofSize: 15, weight: .light)
        static let lightRegular: UIFont = .systemFont(ofSize: 17, weight: .light)
        static let heavyLarge: UIFont = .systemFont(ofSize: 20, weight: .heavy)
        
    }
}
