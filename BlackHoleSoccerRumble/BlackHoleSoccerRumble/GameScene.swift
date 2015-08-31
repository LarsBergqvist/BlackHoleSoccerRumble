import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    let hero = Hero()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    let timeRemainingLabel = SKLabelNode(fontNamed:"Chalkduster")
    var score = 0
    var count = 60
    var timer = NSTimer()

    override func didMoveToView(view: SKView) {
        timeRemainingLabel.text = "Time remaining: \(count)"
        timeRemainingLabel.fontSize = 65;
        timeRemainingLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-250);
        self.addChild(timeRemainingLabel)

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
        
        startGame()
    }
    
    func startGame() {
        count = 60
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
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
            // Bugfix for rounding error in SpriteKit
            hero.moveStuckedHeroIntoScreen()
        }
    }
    
    func goal(node:SKNode) {
        score++
        myLabel.text = "Score: \(score)"
        BlackHole.Eat(node)
    }
    
    
    func didBeginContact(contact:SKPhysicsContact){
        if (contact.bodyA != nil && contact.bodyA.node != nil && contact.bodyB != nil && contact.bodyB.node != nil)
        {
            let node2:SKNode = contact.bodyB.node!;
            let node1:SKNode = contact.bodyA.node!
            let nameA = node1.name;
            let nameB = node2.name;
            if ( nameA == "ball" && nameB == "blackhole")
            {
                goal(node1)
            }
            else if ( nameB == "ball" && nameA == "blackhole")
            {
                goal(node2)
            }
        }
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
    
    
    func update() {
        
        if(count > 0) {
            timeRemainingLabel.text = "Time remaining: \(count--)"
        }
        else {
            timer.invalidate()
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameOverScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            scene.score = score
            self.scene!.view!.presentScene(scene, transition: transition)
        }
        
    }

}
