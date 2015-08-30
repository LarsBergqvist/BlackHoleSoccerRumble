//
//  GameScene.swift
//
//  Created by Lars Bergqvist on 2015-08-26.
//  Copyright (c) 2015 Lars Bergqvist. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    func goal(node:SKNode) {
        score++
        myLabel.text = "Score: \(score)"
        BlackHole.Eat(node)
    }

    let hero = Hero()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    let timeRemainingLabel = SKLabelNode(fontNamed:"Chalkduster")
    var score = 0
    
    
    func didBeginContact(contact:SKPhysicsContact){
        if (contact.bodyA != nil && contact.bodyA.node != nil && contact.bodyB != nil && contact.bodyB.node != nil)
        {
            let node2:SKNode = contact.bodyB.node!;
            let node1:SKNode = contact.bodyA.node!
            let nameA = node1.name;
            let nameB = node2.name;
            if ( nameA == "ball" && nameB == "basket")
            {
                goal(node1)
            }
            else if ( nameB == "ball" && nameA == "basket")
            {
                goal(node2)
            }
            if (nameA == "edge") {
                applyReverseImpulse(node2)
            }
            if (nameB == "edge") {
                applyReverseImpulse(node1)
            }
        }
    }
    
    func applyReverseImpulse(node:SKNode) {
//        node.physicsBody!.applyForce(CGVector(dx:-0.1*node.physicsBody!.velocity.dx,dy:-0.1*node.physicsBody!.velocity.dy))
    }
    
    
    

    func addBricks() {
        let spTexture = SKTexture(imageNamed: "brick")
        
        var xPos = 0
        for i in 1...5 {
            let sp = SKSpriteNode(imageNamed:"brick")
            sp.position = CGPoint(x:CGFloat(xPos), y: self.frame.height-200)
            sp.setScale(1)
            sp.name = "brick"

            let physicsBody = SKPhysicsBody(texture: spTexture, size: sp.size)
            physicsBody.allowsRotation = false
            physicsBody!.dynamic = false
            physicsBody!.mass = 1
            
            
            sp.physicsBody = physicsBody
            self.addChild(sp)
            
            xPos += Int(sp.size.width)
        }
    }

    func addBalls() {
        for i in 1...50 {
            var dice1 = arc4random_uniform(UInt32(self.frame.size.width/2)) + 1
            var y = self.frame.height
            let sp = Ball.CreateSprite(CGFloat(dice1), ypos: y)
            
            self.addChild(sp)
        }

    }
    
    var count = 5
    var timer = NSTimer()
    
    func update() {
        
        if(count > 0) {
            timeRemainingLabel.text = "Time remaining: \(count--)"
        }
        else {
            timer.invalidate()
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameOverScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene!.view!.presentScene(scene, transition: transition)
        }
        
    }
    override func didMoveToView(view: SKView) {
        count = 60
        timeRemainingLabel.text = "Time remaining: \(count)"
        timeRemainingLabel.fontSize = 65;
        timeRemainingLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-250);
        self.addChild(timeRemainingLabel)

        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

        myLabel.text = "Score: \(score)"
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-200);
        self.addChild(myLabel)
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsBody = physicsBody
        self.name = "edge"
        self.physicsWorld.contactDelegate = self
        
        self.addChild(BlackHole.CreateSprite())
        addBricks()
        self.addChild(hero.CreateSprite())
        addBalls()

    }
    
    
    override func keyDown(theEvent: NSEvent) {
        if (theEvent.keyCode == 0x7C){
            hero.MoveRight()
        }
        else if (theEvent.keyCode == 0x7B){
            hero.MoveLeft()
        }
        
        if (theEvent.keyCode == 49){
            hero.Jump()
        }
        if (theEvent.keyCode == 0x7D){
            hero.Stomp()
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (hero.getBottomPosition() < 0)
        {
            hero.moveStuckedHeroIntoScreen()
        }
    }
}
