import Foundation
import SpriteKit

class Ball {
    class func getCategoryBitMask() -> UInt32 {
        return 0x02
    }
    class func CreateSprite(xpos:CGFloat, ypos:CGFloat) -> SKSpriteNode {
        let sp = SKSpriteNode(imageNamed:"football")
        let spTexture = SKTexture(imageNamed: "football")
        sp.position = CGPoint(x:xpos, y:ypos)
        sp.setScale(1)
        sp.physicsBody = SKPhysicsBody(texture: spTexture, size: sp.size)
        sp.physicsBody!.friction = 0.3
        sp.physicsBody!.restitution = 0.8
        sp.physicsBody!.mass = 0.01
        sp.physicsBody!.allowsRotation = true
        sp.physicsBody!.collisionBitMask = BlackHole.getCategoryBitMask() | getCategoryBitMask();
        sp.physicsBody!.categoryBitMask = getCategoryBitMask();
        sp.physicsBody!.contactTestBitMask = BlackHole.getCategoryBitMask();
        sp.name = "ball"
        
        return sp
    }
}