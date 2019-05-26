//
//  Saw.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation
import SpriteKit

class Saw: SKSpriteNode {
    
    init(theme: Theme) {
        let texture = SKTexture(image: theme.saw)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        xScale = 0.45
        yScale = 0.45
        name = "saw"
        physicsBody = SKPhysicsBody(circleOfRadius: self.frame.height/2)
        physicsBody?.affectedByGravity = false
        
        physicsBody?.collisionBitMask = PhysicsCategory.all.rawValue
        physicsBody?.categoryBitMask = PhysicsCategory.saw.rawValue
        
        let action = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration:0.3)
        run(SKAction.repeatForever(action))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

extension Saw {
    enum Pace {
        case normal
        case fast
        
        var value: CGFloat {
            switch self {
            case .normal: return 360
            case .fast: return 120
            }
        }
    }
}
