// ---------------------------------------
// Sprite definitions for 'knight'
// Generated with TexturePacker 3.9.2
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class knight_gfx {

    // sprite names
    let KNIGHT1  = "Knight1"
    let KNIGHT10 = "Knight10"
    let KNIGHT11 = "Knight11"
    let KNIGHT12 = "Knight12"
    let KNIGHT2  = "Knight2"
    let KNIGHT3  = "Knight3"
    let KNIGHT4  = "Knight4"
    let KNIGHT5  = "Knight5"
    let KNIGHT6  = "Knight6"
    let KNIGHT7  = "Knight7"
    let KNIGHT8  = "Knight8"
    let KNIGHT9  = "Knight9"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "knight")


    // individual texture objects
    func Knight1() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT1) }
    func Knight10() -> SKTexture { return textureAtlas.textureNamed(KNIGHT10) }
    func Knight11() -> SKTexture { return textureAtlas.textureNamed(KNIGHT11) }
    func Knight12() -> SKTexture { return textureAtlas.textureNamed(KNIGHT12) }
    func Knight2() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT2) }
    func Knight3() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT3) }
    func Knight4() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT4) }
    func Knight5() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT5) }
    func Knight6() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT6) }
    func Knight7() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT7) }
    func Knight8() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT8) }
    func Knight9() -> SKTexture  { return textureAtlas.textureNamed(KNIGHT9) }


    // texture arrays for animations
    func Knight_running() -> [SKTexture] {
        return [
            Knight1(),
            Knight2(),
            Knight3(),
            Knight4(),
            Knight5(),
            Knight6(),
            Knight7(),
            Knight8(),
            Knight9(),
            Knight10(),
            Knight11(),
            Knight12()
        ]
    }


}
