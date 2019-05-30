//
//  TimeInterval.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-29.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

extension TimeInterval {
    var elapsedTimeFormat: String {
        return String(format: "%.1f s", self.magnitude)
    }
}
