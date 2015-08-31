import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let restartLabel = SKLabelNode(fontNamed:"Chalkduster")
    let instructionsLabel = SKLabelNode(fontNamed:"Chalkduster")
    let instructionsLabel2 = SKLabelNode(fontNamed:"Chalkduster")
    
    var score = 0
        
    override func didMoveToView(view: SKView) {
        instructionsLabel.text = "Game over!"
        instructionsLabel.fontSize = 65;
        instructionsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(instructionsLabel)
        
        instructionsLabel2.text = "Your score was: \(score)"
        instructionsLabel2.fontSize = 55;
        instructionsLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-100);
        self.addChild(instructionsLabel2)

        restartLabel.text = "Press space to restart"
        restartLabel.fontSize = 45;
        restartLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-250);
        self.addChild(restartLabel)
    }

    override func keyDown(theEvent: NSEvent) {
        
        if (theEvent.keyCode == 49){
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameScene(size: self.scene!.size)
            scene.backgroundColor = NSColor.blackColor()
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene!.view!.presentScene(scene, transition: transition)
        }
    }
    
}