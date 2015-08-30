import Foundation
import SpriteKit

class BlackHole {
    class func GetCategoryBitMask() -> UInt32 {
        return 0x02
    }
    
    class func GetCenter() -> CGPoint {
        return CGPoint(x:800, y: 600+30)
    }
    class func GetLeftTopPosition() -> CGPoint {
        return CGPoint(x:800, y: 600)
    }
    
    class func CreateSprite() -> SKSpriteNode {
//        let sp = SKSpriteNode(imageNamed:"Spaceship")
//        let spTexture = SKTexture(imageNamed: "Spaceship")
        let sp = SKSpriteNode(imageNamed:"blackhole")
        let spTexture = SKTexture(imageNamed: "blackhole")
        sp.position = GetLeftTopPosition()
        sp.setScale(1.5)
        var s = sp.size
        sp.physicsBody = SKPhysicsBody( circleOfRadius: 100)
//        sp.physicsBody = SKPhysicsBody( texture: spTexture, alphaThreshold:0.0, size: sp.size)
        sp.physicsBody!.allowsRotation = false
        sp.physicsBody!.dynamic = false
        sp.physicsBody!.mass = 1
        sp.physicsBody!.friction = 1
        sp.physicsBody!.collisionBitMask = GetCategoryBitMask() | 1;
        sp.physicsBody!.categoryBitMask = GetCategoryBitMask();
        sp.physicsBody!.contactTestBitMask = 1;

        sp.name = "basket"
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sp.runAction(SKAction.repeatActionForever(action))
        
        return sp
    }
    
    class func Eat(node:SKNode) {
        node.name = "deadball"
        node.physicsBody!.categoryBitMask = 0
        node.physicsBody!.collisionBitMask = 0
        node.physicsBody!.contactTestBitMask = 0
        let shrink = SKAction.scaleBy(0.8, duration: 0.1)
        node.runAction(shrink)
        let drawnIn = SKAction.moveTo( BlackHole.GetCenter(), duration: 1)
        node.runAction(drawnIn, completion: { () -> Void in
            node.removeFromParent()
        })
        
    }

   
}