//
//  GameScene.swift
//  Black Hole Soccer Rumble
//
//  Created by Lars Bergqvist on 2015-09-01.
//  Copyright (c) 2015 Lars Bergqvist. All rights reserved.
//

import SpriteKit

typealias GoalHandler = (SKNode -> Void)
typealias EatHeroHandler = (SKNode -> Void)
typealias GameOverHandler = (Void -> Void)

class GameScene: SKScene {
    let hero = Hero()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    let timeRemainingLabel = SKLabelNode(fontNamed:"Chalkduster")
    var score = 0
    var count = 60
    var timer = NSTimer()
    var collisionDetector : CollisionDetector?

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
 /*       let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)*/
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsBody = physicsBody
        self.name = "edge"
        
        collisionDetector = CollisionDetector(g:goal, e:heroIntoBlackHole)
        self.physicsWorld.contactDelegate = collisionDetector
        
        self.addChild(BlackHole.CreateSprite())
//        addBricks()
        self.addChild(hero.createSprite())
        addBalls()
        
//        startGame()

        
    }
    
    func heroIntoBlackHole(node:SKNode) {
        BlackHole.eatHero(node,gameOverFunction: self.gameOver)
    }
    
    func goal(node:SKNode) {
//        score++
//        myLabel.text = "Score: \(score)"
        BlackHole.EatBall(node)
    }
    func gameOver() {
/*        timer.invalidate()
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
        
        let scene = GameOverScene(size: self.scene!.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        scene.score = score
        self.scene!.view!.presentScene(scene, transition: transition)
  */
    }
    
    func addBalls() {
        for i in 1...20 {
            var dice1 = arc4random_uniform(UInt32(self.frame.size.width/4)) + 1
            var y = self.frame.height
            let sp = Ball.CreateSprite(CGFloat(dice1), ypos: y)
            
            self.addChild(sp)
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if (hero.getSpriteFrame().contains(location)) {
                hero.stomp()
            }
            else if (location.x < (hero.getSpritePosition().x - hero.getSpriteSize().width/2)) {
                moveState = 1
//                hero.moveLeft()
            }
            else if (location.x > (hero.getSpritePosition().x + hero.getSpriteSize().width/2)) {
                moveState = 2
                //                hero.moveRight()
            }
            if (location.y > (hero.getSpritePosition().y + hero.getSpriteSize().height)) {
                hero.jump()
            }

        }
    }
   
    var moveState = 0
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        moveState = 0
        
//        hero.stopAnimation()
    }
    
    var lastFrameTime = 0.0
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (hero.getBottomPosition() < 0)
        {
            // Bugfix for rounding error in SpriteKit
            hero.moveStuckedHeroIntoScreen()
        }
        
        // Calculate the time since this method was last called
        let deltaTime = currentTime - lastFrameTime // Move at 3 units per second
   //     let movementSpeed = 3.0
        // Multiply by deltaTime to work out how far
        // an object needs to move this frame someMovingObject.move(distance: movementSpeed * deltaTime)
        // Set last frame time to current time, so that // we can calculate the delta time when we're next // called
        
        if (deltaTime > 0.05)
        {
            lastFrameTime = currentTime
            if (moveState == 1) {
                hero.moveLeft()
            }
            else if (moveState == 2) {
                hero.moveRight()
            }
            else {
                hero.stopAnimation()
            }
        
            
        }
    }
}
