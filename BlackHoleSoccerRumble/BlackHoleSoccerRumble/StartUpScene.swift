import Foundation
import SpriteKit

class StartUpScene: SKScene {
    
    let restartLabel = SKLabelNode(fontNamed:"Chalkduster")
    let instructionsLabel = SKLabelNode(fontNamed:"Chalkduster")
    let instructionsLabel2 = SKLabelNode(fontNamed:"Chalkduster")

    override func didMoveToView(view: SKView) {
        instructionsLabel.text = "Instructions:"
        instructionsLabel.fontSize = 25;
        instructionsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(instructionsLabel)

        instructionsLabel2.text = "← and → moves the Knight. Use Space to jump and ↓ to rumble."
        instructionsLabel2.fontSize = 25;
        instructionsLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-50);
        self.addChild(instructionsLabel2)
        
        restartLabel.text = "Press space to start"
        restartLabel.fontSize = 65;
        restartLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-250);
        self.addChild(restartLabel)

    }

    override func keyDown(theEvent: NSEvent) {
        
        if (theEvent.keyCode == 49){
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFit
            scene.backgroundColor = NSColor.blackColor()

            self.scene!.view!.presentScene(scene, transition: transition)
        }
    }

}