//
//  Theme.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation
import UIKit

enum Theme: String {
    case `default`, dark
}

extension Theme {
    var saw: UIImage {
        switch self {
        case .dark: return #imageLiteral(resourceName: "Saw")
        case .default: return #imageLiteral(resourceName: "Saw")
        }
    }
    
    var finger: UIImage {
        return #imageLiteral(resourceName: "Finger")
    }
}
