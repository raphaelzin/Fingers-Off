//
//  Array.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
