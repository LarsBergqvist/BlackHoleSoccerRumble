import Foundation
import SpriteKit

class Hero {
    
    var leftAnimRunning = false
    var rightAnimRunning = false
    let knightTimePerFrame = 0.1
    let pixelsPerMovement:Float = 20.0
    var sp = SKSpriteNode()
    let gubbe = knight_gfx()

    init() {
        
    }
    
    func getBottomPosition() -> CGFloat {
        return sp.position.y - CGFloat(sp.size.height)/2
    }
    
    func moveStuckedHeroIntoScreen() {
        var y = sp.position.y
        var h = CGFloat(sp.size.height)
        sp.position.y = h/2
    }
    
    func MoveRight() {
        if (!rightAnimRunning || leftAnimRunning) {
            sp.xScale = CGFloat(1.0)
            let walk = SKAction.animateWithTextures(gubbe.Knight_running(), timePerFrame: knightTimePerFrame)
            
            sp.runAction(walk, completion: { () -> Void in
                self.rightAnimRunning = false
                
            })
            rightAnimRunning = true
        }
        var moveAction = SKAction.moveByX(40, y:0, duration:0.1);
        moveAction.timingMode = SKActionTimingMode.EaseInEaseOut
        sp.runAction(moveAction)
    }
    
    func MoveLeft() {
        if (!leftAnimRunning || rightAnimRunning) {
            sp.xScale = -CGFloat(1.0)
            let walk = SKAction.animateWithTextures(gubbe.Knight_running(), timePerFrame: knightTimePerFrame)
            
            sp.runAction(walk, completion: { () -> Void in
                self.leftAnimRunning = false
                
            })
            leftAnimRunning = true
        }
        var moveAction = SKAction.moveByX(-40, y:0, duration:0.1);
        moveAction.timingMode = SKActionTimingMode.EaseInEaseOut
        sp.runAction(moveAction)
    }
    
    func Jump() {
        sp.physicsBody?.applyImpulse(CGVectorMake(0, 1000))        
    }
    
    func Stomp() {
        sp.physicsBody?.applyImpulse(CGVectorMake(0, -3000))        
    }
    
    func CreateSprite() -> SKSpriteNode {
        let sheet = SKTextureAtlas(named: "knight")
        let texture = sheet.textureNamed("Knight1")
        sp = SKSpriteNode(texture: texture)
        sp.position = CGPoint(x:500,y:100)
        sp.setScale(CGFloat(1.0))
        
        sp.physicsBody = SKPhysicsBody(texture: texture, size: sp.size)
        sp.physicsBody!.friction = 0.6
        sp.physicsBody!.restitution = 0.1
        sp.physicsBody!.mass = 1
        sp.physicsBody!.allowsRotation = false

        return sp
    }
}