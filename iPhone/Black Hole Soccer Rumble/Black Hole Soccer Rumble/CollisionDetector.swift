import Foundation
import SpriteKit

class CollisionDetector : NSObject, SKPhysicsContactDelegate {

    var goalHandler : GoalHandler?
    var eatHeroHandler : EatHeroHandler?
    
    init(g:GoalHandler,e:EatHeroHandler) {
        goalHandler = g
        eatHeroHandler = e
    }
    
    func didBeginContact(contact:SKPhysicsContact){
        if (contact.bodyA != nil && contact.bodyA.node != nil && contact.bodyB != nil && contact.bodyB.node != nil)
        {
            let node2:SKNode = contact.bodyB.node!;
            let node1:SKNode = contact.bodyA.node!
            let name1 = node1.name;
            let name2 = node2.name;
            if ( name1 == "ball" && name2 == "blackhole")
            {
                goalHandler?(node1)
            }
            else if ( name2 == "ball" && name1 == "blackhole")
            {
                goalHandler?(node2)
            }
            else if ( name1 == "hero" && name2 == "blackhole")
            {
                eatHeroHandler?(node1)
            }
            else if ( name2 == "hero" && name1 == "blackhole")
            {
                eatHeroHandler?(node2)
            }
            
        }
    }

}