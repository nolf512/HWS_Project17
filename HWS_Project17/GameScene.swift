//
//  GameScene.swift
//  HWS_Project17
//
//  Created by J on 2021/04/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfieid: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabal: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabal.text = "score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        
        starfieid = SKEmitterNode(fileNamed: "starfield")
        starfieid.position = CGPoint(x: 1024, y: 384)
        starfieid.advanceSimulationTime(10.0)
        addChild(starfieid)
        starfieid.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        addChild(player)
        
        scoreLabal = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabal.position = CGPoint(x: 16, y: 16)
        scoreLabal.horizontalAlignmentMode = .left
        addChild(scoreLabal)
        
        score = 0
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
          }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
