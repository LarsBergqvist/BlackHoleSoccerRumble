import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func keyDown(theEvent: NSEvent) {
        
        if (theEvent.keyCode == 49){
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene!.view!.presentScene(scene, transition: transition)
        }
    }
    
}