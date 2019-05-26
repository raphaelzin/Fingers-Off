//
//  Finger.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation
import SpriteKit

class Finger: SKSpriteNode {
    
    init(theme: Theme) {
        
        let texture = SKTexture(image: theme.finger)
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "finger"
        xScale = 0.8
        yScale = 0.8
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width/2)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.finger.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategory.all.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
