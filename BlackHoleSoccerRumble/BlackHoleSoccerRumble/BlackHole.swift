import Foundation
import SpriteKit

class BlackHole {
    class func getCategoryBitMask() -> UInt32 {
        return 0x02
    }
    
    class func getCenterPosition() -> CGPoint {
        return CGPoint(x:800, y: 600)
    }
    
    class func CreateSprite() -> SKSpriteNode {
        let sp = SKSpriteNode(imageNamed:"blackhole")
        let spTexture = SKTexture(imageNamed: "blackhole")
        sp.position = getCenterPosition()
        sp.setScale(1.5)
        var s = sp.size
        sp.physicsBody = SKPhysicsBody( circleOfRadius: 100)
        sp.physicsBody!.allowsRotation = false
        sp.physicsBody!.dynamic = false
        sp.physicsBody!.mass = 1
        sp.physicsBody!.friction = 1
        sp.physicsBody!.collisionBitMask = getCategoryBitMask() | 1;
        sp.physicsBody!.categoryBitMask = getCategoryBitMask();
        sp.physicsBody!.contactTestBitMask = 1;

        sp.name = "blackhole"
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sp.runAction(SKAction.repeatActionForever(action))
        
        return sp
    }
    
    class func EatBall(node:SKNode) {
        node.name = "deadball"
        node.physicsBody!.categoryBitMask = 0
        node.physicsBody!.collisionBitMask = 0
        node.physicsBody!.contactTestBitMask = 0
        let shrink = SKAction.scaleBy(0.1, duration: 1)
        node.runAction(shrink)
        let drawnIn = SKAction.moveTo( BlackHole.getCenterPosition(), duration: 1)
        node.runAction(drawnIn, completion: { () -> Void in
            node.removeFromParent()
        })
        
    }
    
    class func eatHero(node:SKNode, gameOverFunction:GameOverHandler) {
        node.name = "deadhero"
        node.physicsBody!.allowsRotation = true
        node.physicsBody!.categoryBitMask = 0
        node.physicsBody!.collisionBitMask = 0
        node.physicsBody!.contactTestBitMask = 0
        let rot = SKAction.rotateByAngle(10, duration: 1)
        node.runAction(rot)
        let shrink = SKAction.scaleBy(0.2, duration: 1)
        node.runAction(shrink)
        let drawnIn = SKAction.moveTo( BlackHole.getCenterPosition(), duration: 1)
        node.runAction(drawnIn, completion: { () -> Void in
            gameOverFunction()
        })
        
    }

   
}