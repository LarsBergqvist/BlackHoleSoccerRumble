import Foundation
import SpriteKit

class Hero {
    
    var leftAnimRunning = false
    var rightAnimRunning = false
    let knightTimePerFrame = 0.1
    let pixelsPerMovement:Float = 20.0
    var sp = SKSpriteNode()
    let gfx = knight_gfx()

    init() {
        
    }

    func getSpriteFrame() -> CGRect {
        return sp.frame
    }

    func getSpriteSize() -> CGSize {
        return sp.size
    }

    func getSpritePosition() -> CGPoint {
        return sp.position
    }
    
    func getBottomPosition() -> CGFloat {
        return sp.position.y - CGFloat(sp.size.height)/2
    }
    
    func moveStuckedHeroIntoScreen() {
        var y = sp.position.y
        var h = CGFloat(sp.size.height)
        sp.position.y = h/2
    }
    
    func moveRight() {
        if (!rightAnimRunning || leftAnimRunning) {
            sp.xScale = CGFloat(1.0)
            let walk = SKAction.animateWithTextures(gfx.Knight_running(), timePerFrame: knightTimePerFrame)

            sp.runAction(SKAction.repeatActionForever(walk) , withKey: "rightAnim")
            rightAnimRunning = true
        }
        var moveAction = SKAction.moveByX(40, y:0, duration:0.1);
        moveAction.timingMode = SKActionTimingMode.EaseInEaseOut
        sp.runAction(moveAction)
    }
    
    
    func stopAnimation() {
        sp.removeActionForKey("rightAnim")
        sp.removeActionForKey("leftAnim")
        leftAnimRunning = false
        rightAnimRunning = false
    }
    
    func moveLeft() {
        if (!leftAnimRunning || rightAnimRunning) {
            sp.xScale = -CGFloat(1.0)
            let walk = SKAction.animateWithTextures(gfx.Knight_running(), timePerFrame: knightTimePerFrame)
            
            sp.runAction(SKAction.repeatActionForever(walk), withKey: "leftAnim")
            leftAnimRunning = true
        }
        var moveAction = SKAction.moveByX(-40, y:0, duration:0.1);
        moveAction.timingMode = SKActionTimingMode.EaseInEaseOut
        sp.runAction(moveAction)
    }
    
    func jump() {
        sp.physicsBody?.applyImpulse(CGVectorMake(0, 1000))        
    }
    
    func stomp() {
        sp.physicsBody?.applyImpulse(CGVectorMake(0, -3000))        
    }
    
    func createSprite() -> SKSpriteNode {
        let sheet = SKTextureAtlas(named: "knight")
        let texture = sheet.textureNamed("Knight1")
        sp = SKSpriteNode(texture: texture)
        sp.position = CGPoint(x:500,y:100)
        sp.setScale(CGFloat(1.0))
        
        sp.physicsBody = SKPhysicsBody(texture: texture, size: sp.size)
        sp.physicsBody!.friction = 0.9
        sp.physicsBody!.restitution = 0.1
        sp.physicsBody!.mass = 1
        sp.physicsBody!.allowsRotation = false
        sp.name = "hero"

        return sp
    }
}