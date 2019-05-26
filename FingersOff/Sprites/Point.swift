//
//  Point.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-25.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation
import SpriteKit

class Point: SKSpriteNode {
    init(theme: Theme) {
        
        let texture = SKTexture(image: theme.finger)
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "point"
        xScale = 0.1
        yScale = 0.1
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width/2)
        physicsBody?.affectedByGravity = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.point.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategory.all.rawValue
    }
    
    func spawn() {
        let rotate = SKAction.rotate(byAngle: π*2, duration: 0.2)
        let scaleUp = SKAction.scale(to: 0.6, duration: 0.2)
        
        run(SKAction.group([rotate, scaleUp]))
    }
    
    func collect() {
        let invalidadePhysics = SKAction.run {
            self.physicsBody = nil
        }
        let rotate = SKAction.rotate(byAngle: π*2, duration: 0.2)
        let scaleUp = SKAction.scale(to: 0, duration: 0)
        let remove = SKAction.removeFromParent()
        
        run(SKAction.group([invalidadePhysics, rotate, scaleUp, remove]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
