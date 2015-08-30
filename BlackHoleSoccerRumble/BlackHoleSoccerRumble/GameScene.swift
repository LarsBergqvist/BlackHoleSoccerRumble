//
//  GameScene.swift
//
//  Created by Lars Bergqvist on 2015-08-26.
//  Copyright (c) 2015 Lars Bergqvist. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    let hero = Hero()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    var score = 0
    
    func didBeginContact(contact:SKPhysicsContact){
        if (contact.bodyA != nil && contact.bodyA.node != nil && contact.bodyB != nil && contact.bodyB.node != nil)
        {
            let node2:SKNode = contact.bodyB.node!;
            let node1:SKNode = contact.bodyA.node!
            let catA = node1.physicsBody!.categoryBitMask
            let catB = node2.physicsBody!.categoryBitMask
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
    func goal(node:SKNode) {
        score++
        myLabel.text = "Score: \(score)"
        BlackHole.Eat(node)
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
    
    override func didMoveToView(view: SKView) {
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
        if (theEvent.keyCode == 14){ // E=right
            hero.MoveRight()
        }
        else if (theEvent.keyCode == 12){ // Q=left
            hero.MoveLeft()
        }
        
        if (theEvent.keyCode == 49){
            hero.Jump()
        }
        if (theEvent.keyCode == 1){
            hero.Stomp()
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
