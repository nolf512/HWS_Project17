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
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    
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
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        
          }
    
    @objc func createEnemy(){
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: "enemy")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask =  1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {

        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y =  100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion =  SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        
        isGameOver = true
    }
    
}
