//
//  GameViewController.swift
//  FingersOff
//
//  Created by Raphael Souza on 2019-05-21.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        let scene = GameScene(size: view.frame.size)
        scene.statsUpdaterDelegate = self
        scene.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

private extension GameViewController {
    func configureLayout() {
        view.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12)
            ])
    }
}

extension GameViewController: GameStatsUpdaterDelegate {
    func updateTimer(value: String) {
        timerLabel.text = value
    }
    
    func updateScore() {
        print("Score!")
    }
}
