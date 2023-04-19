import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var scene: SKScene {
        let scene = GameScene()
        
        scene.size = CGSize(width: 500, height: 500)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
    }
}
