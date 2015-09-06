import SpriteKit

typealias GoalHandler = (SKNode -> Void)
typealias EatHeroHandler = (SKNode -> Void)
typealias GameOverHandler = (Void -> Void)

class GameScene: SKScene, SKPhysicsContactDelegate {

    let hero = Hero()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    let timeRemainingLabel = SKLabelNode(fontNamed:"Chalkduster")
    var score = 0
    var count = 60
    var timer = NSTimer()
    var collisionDetector : CollisionDetector?

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

        collisionDetector = CollisionDetector(g:goal, e:heroIntoBlackHole)
        self.physicsWorld.contactDelegate = collisionDetector
        
        self.addChild(BlackHole.CreateSprite())
        addBricks()
        self.addChild(hero.createSprite())
        addBalls()
        
        startGame()
    }
    
    func startGame() {
        count = 60
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if (theEvent.keyCode == 0x7C){
            hero.moveRight()
        }
        else if (theEvent.keyCode == 0x7B){
            hero.moveLeft()
        }
        
        if (theEvent.keyCode == 49){
            hero.jump()
        }
        if (theEvent.keyCode == 0x7D){
            hero.stomp()
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
    
    func heroIntoBlackHole(node:SKNode) {
        BlackHole.eatHero(node,gameOverFunction: self.gameOver)
    }
    
    func goal(node:SKNode) {
        score++
        myLabel.text = "Score: \(score)"
        BlackHole.EatBall(node)
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
            physicsBody.dynamic = false
            physicsBody.mass = 1
            
            
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
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
        
        let scene = GameOverScene(size: self.scene!.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        scene.score = score
        self.scene?.view?.presentScene(scene, transition: transition)
        
    }

}
