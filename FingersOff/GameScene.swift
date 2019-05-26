//
//  GameScene.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var gameManager: GameManager!
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var velocity: CGPoint = .zero
    
    var movingFinger = false
    var pace: Saw.Pace = .normal
    private var dt: TimeInterval!
    
    // Sprites on screen
    var finger: Finger!
    var saws: [Saw] = .init()
    
    var fingerLocation: CGPoint {
        return finger.position
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        gameManager = GameManager(scene: self)
        gameManager.setupGame()
        backgroundColor = .white
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        let node = atPoint(touchLocation)
        
        if node == finger {
            movingFinger = true
            
            if gameManager.state == .waitingStart {
                gameManager.startGame()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self), movingFinger else { return }
        finger.position = touchLocation
    }
    
    func moveSpriteTowards(location: CGPoint, sprite: SKSpriteNode) -> CGPoint {
        let offset = location - sprite.position
        let direction = offset.normalized
        velocity = direction * pace.value
        return velocity
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        sprite.position += amountToMove
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingFinger = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        dt = currentTime - self.lastUpdateTime
        
        if gameManager.state == .playing {
            for saw in saws {
                moveSprite(sprite: saw, velocity: moveSpriteTowards(location: fingerLocation,sprite: saw))
            }
        }
        
        self.lastUpdateTime = currentTime
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = [contact.bodyA, contact.bodyB]
        
        // Makes sure it's a contact envolving the player
        guard let fingerBody = finger.physicsBody, bodies.contains(fingerBody) else { return }
        
        // Get other node
        guard let node = (bodies.filter { $0 != fingerBody }.first),
            let physicsCategory = PhysicsCategory(rawValue: node.categoryBitMask) else { return }
        
        switch physicsCategory {
        case .point:
            gameManager.collect(point: node.node)
        case .saw:
            gameManager.endGame()
        case .removeSaw, .slowClock:
            gameManager.collected(powerUp: physicsCategory.powerUp)
        default:
            print("Non relevant cases")
        }
        
    }
}
