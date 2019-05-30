//
//  GameManager.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

struct Configuration {
    let sawSpawnInterval: TimeInterval = 4
}

enum RecurrentAction: String {
    case spawnSaw, spawnPowerUp, updateTimer
}

class GameManager {
    private unowned var  gameScene: GameScene
    private(set) var state: GameState = .waitingStart
    private let config = Configuration()
    
    private var startTimestamp: Date?
    
    var elapsedTime: TimeInterval? {
        return startTimestamp?.timeIntervalSinceNow
    }
    
    private(set) var score = 0 {
        didSet {
            print("New score: \(score)")
        }
    }
    
    init(scene: GameScene) {
        self.gameScene = scene
    }
    
    func spawnSaw() {
        let saw = Saw(theme: .dark)
        saw.position = randomSpanCorner()
        
        gameScene.saws.append(saw)
        gameScene.addChild(saw)
    }
    
    func spawnPowerUp() {
        
    }
    
    func spawnPoint() {
        let point = Point(theme: .dark)
        point.position = randomSpanPosition()
        
        gameScene.addChild(point)
        point.spawn()
    }
    
    func setupGame() {
        let finger = Finger(theme: .dark)
        finger.position = CGPoint(x: gameScene.frame.midX, y: gameScene.frame.midY)
        gameScene.finger = finger
        gameScene.addChild(finger)
        
        score = 0
    }
    
    func collect(point: SKNode?) {
        guard let point = point as? Point else { return }
        score += 1
        point.collect()
        spawnPoint()
    }
    
    func collected(powerUp: PowerUp?) {
        guard let powerUp = powerUp else { return }
        
        print("Did collect \(powerUp)")
    }
    
    func endGame() {
        print("Should end game")
        state = .finished
        
        gameScene.removeAction(forKey: RecurrentAction.spawnSaw.rawValue)
        gameScene.removeAction(forKey: RecurrentAction.spawnPowerUp.rawValue)
        gameScene.removeAction(forKey: RecurrentAction.updateTimer.rawValue)
    }
    
    func startGame() {
        state = .playing
        startTimestamp = Date()
        
        setupTimers()
        spawnPoint()
    }
    
    private func setupTimers() {
        let spawnSawAt = SKAction.run(spawnSaw)
        let wait = SKAction.wait(forDuration: config.sawSpawnInterval)
        
        let spawnSawGroup = SKAction.sequence([spawnSawAt, wait])
        gameScene.run(SKAction.repeatForever(spawnSawGroup), withKey: RecurrentAction.spawnSaw.rawValue)
        
        gameScene.timerUpdater()
    }
    
}

// MARK: Helper private methods

extension GameManager {
    private func randomSpanPosition() -> CGPoint {
        let maxX = gameScene.frame.maxX - gameScene.frame.width*0.1
        let minX = gameScene.frame.minX + gameScene.frame.width*0.1
        
        let maxY = gameScene.frame.maxY - gameScene.frame.height*0.1
        let minY = gameScene.frame.minY + gameScene.frame.height*0.1
        
        let randomX: CGFloat = .random(in: minX...maxX)
        let randomY: CGFloat = .random(in: minY...maxY)
        
        return .init(x: randomX, y: randomY)
    }
    
    private func randomSpanCorner() -> CGPoint {
        let leftBottom: CGPoint = .zero
        let rightBottom: CGPoint = .init(x: gameScene.view?.bounds.width ?? UIScreen.main.bounds.width, y: 0)
        
        let leftTop: CGPoint = .init(x: 0, y: gameScene.view?.bounds.height ?? UIScreen.main.bounds.height)
        let rightTop: CGPoint = .init(x: gameScene.view?.bounds.width ?? UIScreen.main.bounds.width,
                                      y: gameScene.view?.bounds.height ?? UIScreen.main.bounds.height)
        
        return [leftBottom, rightBottom, leftTop, rightTop].randomItem() ?? leftTop
    }

}
