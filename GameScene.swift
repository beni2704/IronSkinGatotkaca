import SpriteKit

struct PhysicsCategory {
    static let player: UInt32 = 0
    static let coin: UInt32 = 0b1
    static let deathCoin: UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playerTexture = SKTexture(imageNamed: "gatotkaca")
    let hearthTexture = SKTexture(imageNamed: "hearth-fill")
    var player: SKSpriteNode!
    var ground: SKSpriteNode!
    var isMovingLeft = false
    var deathCoin: SKSpriteNode!
    var coin: SKSpriteNode!
    var hearth1: SKSpriteNode!
    var hearth2: SKSpriteNode!
    var hearth3: SKSpriteNode!
    var isGamePaused = false
    var story2 = false
    var story3 = false
    var story4 = false
    var score = 0
    var highscore = 0
    let scoreLabel = SKLabelNode(text: "Score: 0")
    var pauseButton: SKSpriteNode!
    var currCharacter: Character!
    
    var popUpBg: SKSpriteNode!
    var popUpTitle: SKLabelNode!
    var popUpDesc: SKLabelNode!
    var popUpDesc2: SKLabelNode!
    var popUpImage: SKSpriteNode!
    var popUpButton1: SKSpriteNode!
    var popUpButton2: SKSpriteNode!
    
    func createWelcome(){
        isGamePaused = true
        
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Tutorial"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2 + 170)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "To play this game, you need to know the basic controls. You can move the player character by swiping right or left on the screen. The objective of the game is to collect as many coins as possible to achieve a high score. However, the player must avoid death coins, as they will reduce the player's heart. If the player collides with a death coins, the player will lose one heart out of the three hearts provided at the beginning of the game. To get a high score, the player must collect coins and avoid rocks for as long as possible. With these basic instructions, you're ready to start playing the game and achieving a high score!"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 300)
        popUpDesc.fontSize = 12
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY + 10)
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_continue")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 300)
        popUpButton1.name = "resumeButton"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height + 60
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
        
    }
    
    func createPopUpStory(){
        closePausePopUp()
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "\(currCharacter.charName) Story"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2 + 80)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Gatotkaca was born to Bima and Arimbi, but was abandoned by his mother and raised by the giant Arawana. As a young boy, he displayed extraordinary strength and courage, and was soon recognized as a formidable warrior. (1/4, Click next to continue story)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 150)
        popUpDesc.fontSize = 12
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_next")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 150)
        popUpButton1.name = "next1"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height + 80
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func createPopUpStory2(){
        closePausePopUp()
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "\(currCharacter.charName) Story"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        if !story2 {
            popUpDesc.text = "Get 50 score to unlock this story"
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2)
        }else {
            popUpDesc.text = "When his father Bima went into battle against the Kurawa in the Mahabharata war, Gatotkaca joined him and fought bravely against the enemy. His iron-like skin made him almost invulnerable to most weapons, and he proved to be a valuable asset to the Pandawa army. (2/4, Click next to continue story)"
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        }
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.fontSize = 12
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY + 10)
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_next")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.minY - 30)
        popUpButton1.name = "next2"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height
        
        popUpBg.size = CGSize(width: 200, height: totalHeight + 70)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func createPopUpStory3(){
        closePausePopUp()
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "\(currCharacter.charName) Story"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        if !story3 {
            popUpDesc.text = "Get 100 score to unlock this story"
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2)
        }else {
             popUpDesc.text = "After the war, Gatotkaca returned to his homeland of Pringgandani, where he married his cousin Dewi Kunti. Together, they had a son named Surya Alam, who inherited his father's strength and bravery. (3/4, Click next to continue story)"
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        }
        
       
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.fontSize = 12
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY + 10)
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_next")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.minY - 30)
        popUpButton1.name = "next3"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height
        
        popUpBg.size = CGSize(width: 200, height: totalHeight + 70)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func createPopUpStory4(){
        closePausePopUp()
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "\(currCharacter.charName) Story"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        
        if !story4 {
            popUpDesc.text = "Get 200 score to unlock this story"
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2)
        }else {
            popUpDesc.text = "Later in life, Gatotkaca faced his greatest challenge when he was summoned to battle the demon king Kala Rau. Despite his invulnerability, Kala Rau was able to defeat Gatotkaca by using magic to weaken him. However, Gatotkaca was ultimately able to triumph by using his wits and strategy to outsmart the demon."
            popUpDesc.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        }
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.fontSize = 12
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY + 10)
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_resume")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.minY - 30)
        popUpButton1.name = "resumeButton"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height
        
        popUpBg.size = CGSize(width: 200, height: totalHeight + 70)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func createPausePopUp(){
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Game is Paused"
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpBg.frame.maxY + 20)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        let currPlayerTexture = SKTexture(imageNamed: currCharacter.charImage)
        popUpImage = SKSpriteNode(texture: currPlayerTexture, size: CGSize(width: 40, height: 80))
        popUpImage.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 70)
        popUpImage.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Character : \(currCharacter.charName)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpImage.frame.maxY - 120)
        popUpDesc.fontSize = 18
        
        popUpDesc2 = SKLabelNode()
        popUpDesc2.text = "Your highscore was : \(highscore)"
        popUpDesc2.preferredMaxLayoutWidth = 170
        popUpDesc2.numberOfLines = 0
        popUpDesc2.fontColor = UIColor.black
        popUpDesc2.horizontalAlignmentMode = .center
        popUpDesc2.zPosition = 101
        popUpDesc2.position = CGPoint(x: size.width/2, y: popUpDesc.frame.minY - 45)
        popUpDesc2.fontSize = 18
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_story")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc2.frame.maxY - 70)
        popUpButton1.name = "storyButton"
        
        popUpButton2 = SKSpriteNode(imageNamed: "button_resume")
        popUpButton2.size = CGSize(width: 120, height: 40)
        popUpButton2.zPosition = 101
        popUpButton2.position = CGPoint(x: size.width/2, y: popUpButton1.frame.maxY - 70)
        popUpButton2.name = "resumeButton"
        
        let titleHeight = popUpTitle.frame.size.height
        let imageHeight = popUpImage.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let desc2Height = popUpDesc2.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        let button2Height = popUpButton2.frame.size.height
        
        let totalHeight = titleHeight + imageHeight + descHeight + desc2Height + button1Height + button2Height + 130
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpImage)
        addChild(popUpDesc)
        addChild(popUpDesc2)
        addChild(popUpButton1)
        addChild(popUpButton2)
    }
    
    func closePausePopUp(){
        popUpBg.removeFromParent()
        popUpTitle.removeFromParent()
        if popUpImage != nil {
            popUpImage.removeFromParent()
        }
        popUpDesc.removeFromParent()
        if popUpDesc2 != nil{
            popUpDesc2.removeFromParent()
        }
        popUpButton1.removeFromParent()
        if popUpButton2 != nil{
            popUpButton2.removeFromParent()
        }
    }
    
    func togglePause() {
        isGamePaused = !isGamePaused
        
        if isGamePaused {
            createPausePopUp()
            player.isPaused = true
            coin.isPaused = true
            deathCoin.isPaused = true
            physicsWorld.speed = 0.0
        } else {
            closePausePopUp()
            player.isPaused = false
            coin.isPaused = false
            deathCoin.isPaused = false
            physicsWorld.speed = 1.0
        }
    }
    
    func createChar(){
        currCharacter = Character(charName: "Gatotkaca", charImage: "gatotkaca", charStory1: "hello", charStory2: "nice", charStory3: "cerita3")
    }
    
    func createGround(){
        ground = SKSpriteNode(color: UIColor.brown, size: CGSize(width: size.width, height: size.height/8))
        ground.position = CGPoint(x: size.width / 2, y: ground.size.height / 2)
        addChild(ground)
    }

    func createPlayer(){
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 40, height: 80))
        player.position = CGPoint(x: size.width / 2, y: ground.frame.maxY + player.size.height / 2)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.coin | PhysicsCategory.deathCoin
        player.physicsBody?.collisionBitMask = 0
        addChild(player)
    }
    
    func createHearth() {
        hearth1 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth1.position = CGPoint(x: size.width / 2 - 20, y: frame.maxY - 30)
        hearth2 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth2.position = CGPoint(x: size.width / 2, y: frame.maxY - 30)
        hearth3 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth3.position = CGPoint(x: size.width / 2 + 20, y: frame.maxY - 30)
        addChild(hearth1)
        addChild(hearth2)
        addChild(hearth3)
    }
    
    func createDeathCoin() {
        let deathCoinTexture = SKTexture(imageNamed: "death-coin")
        deathCoin = SKSpriteNode(texture: deathCoinTexture)
        deathCoin.size = CGSize(width: 25, height: 25)
        let randomX = CGFloat.random(in: deathCoin.size.width...size.width - deathCoin.size.width)
        deathCoin.position = CGPoint(x: randomX, y: size.height)
        deathCoin.physicsBody = SKPhysicsBody(rectangleOf: deathCoin.size)
        deathCoin.physicsBody?.categoryBitMask = PhysicsCategory.deathCoin
        deathCoin.physicsBody?.contactTestBitMask = PhysicsCategory.player
        deathCoin.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        deathCoin.physicsBody?.linearDamping = 10
        if !isGamePaused {
            addChild(deathCoin)
        }
    }
    
    func createCoin() {
        let coinTexture = SKTexture(imageNamed: "coin")
        coin = SKSpriteNode(texture: coinTexture)
        coin.size = CGSize(width: 25, height: 25)
        let randomX = CGFloat.random(in: coin.size.width...size.width - deathCoin.size.width)
        coin.position = CGPoint(x: randomX, y: size.height)
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = PhysicsCategory.coin
        coin.physicsBody?.contactTestBitMask = PhysicsCategory.player
        coin.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        coin.physicsBody?.linearDamping = 10
        if !isGamePaused {
            addChild(coin)
        }
    }
    
    func createPause(){
        let pauseTexture = SKTexture(imageNamed: "button_pause")
        pauseButton = SKSpriteNode(texture: pauseTexture)
        pauseButton.size = CGSize(width: 50, height: 20)
        pauseButton.position = CGPoint(x: size.width/2 - 100, y: self.frame.size.height - pauseButton.size.height/2 - 10)
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }

    func createScore(){
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.fontColor = UIColor.black
        addChild(scoreLabel)
    }
    
    func createPopUpGameOver(){
        if highscore < score {
            highscore = score
        }
        isGamePaused = true
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 250))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Game Over"
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpBg.frame.maxY - 50)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Your \(currCharacter.charName) score was : \(score)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 80)
        popUpDesc.fontSize = 18
        
        popUpDesc2 = SKLabelNode()
        popUpDesc2.text = "Your \(currCharacter.charName) highscore now : \(highscore)"
        if(score >= highscore && !story2 && highscore >= 50) {
            story2 = true
            popUpDesc2.text = "Your \(currCharacter.charName) highscore now : \(highscore) (New Story unlocked)"
        }
        if(score >= highscore && !story3 && highscore >= 100) {
            story3 = true
            popUpDesc2.text = "Your \(currCharacter.charName) highscore now : \(highscore) (New Story unlocked)"
        }
        if(score >= highscore && !story4 && highscore >= 200) {
            story4 = true
            popUpDesc2.text = "Your \(currCharacter.charName) highscore now : \(highscore) (New Story unlocked)"
        }
        
        popUpDesc2.preferredMaxLayoutWidth = 170
        popUpDesc2.numberOfLines = 0
        popUpDesc2.fontColor = UIColor.black
        popUpDesc2.zPosition = 101
        popUpDesc2.position = CGPoint(x: size.width/2, y: popUpDesc.frame.minY - 70)
        popUpDesc2.fontSize = 18
        
        popUpButton1 = SKSpriteNode(imageNamed: "button_retry")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc2.frame.maxY - 90)
        popUpButton1.name = "retryButton"
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpDesc2)
        addChild(popUpButton1)
    }
    
    func closePopUpGameOver(){
        popUpBg.removeFromParent()
        popUpTitle.removeFromParent()
        popUpDesc.removeFromParent()
        popUpDesc2.removeFromParent()
        popUpButton1.removeFromParent()
        refreshGame()
    }
    
    func refreshGame(){
        isGamePaused = false
        createHearth()
        scoreLabel.text = "Score: 0"
        score = 0
        player.position = CGPoint(x: size.width / 2, y: ground.frame.maxY + player.size.height / 2)
    }
    
    override func didMove(to view: SKView) {
        
        createWelcome()
        backgroundColor = UIColor.systemOrange
        
        let waitAction = SKAction.wait(forDuration: 0.7)
        let waitAction5s = SKAction.wait(forDuration: 2)
        
        let createDeathCoinAction = SKAction.run(createDeathCoin)
        let sequenceAction = SKAction.sequence([createDeathCoinAction, waitAction5s])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        run(repeatAction)
        
        let createCoinAction = SKAction.run(createCoin)
        let sequenceActionBread = SKAction.sequence([createCoinAction, waitAction])
        let repeatActionCoin = SKAction.repeatForever(sequenceActionBread)
        run(repeatActionCoin)
        
        
        createChar()
        createGround()
        createPlayer()
        createHearth()
        createPause()
        createScore()
        
        physicsWorld.contactDelegate = self

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.coin {
            contact.bodyB.node?.removeFromParent()
            score += 1
            
            scoreLabel.text = "Score: \(score)"
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.deathCoin {
            contact.bodyB.node?.removeFromParent()
            
            if hearth3.parent != nil {
                hearth3.removeFromParent()
            } else if hearth2.parent != nil {
                hearth2.removeFromParent()
            } else if hearth1.parent != nil {
                hearth1.removeFromParent()
                createPopUpGameOver()
            }
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let detectTouchLeft = player.position.x
            let location = touch.location(in: self)
            if location.x < detectTouchLeft && !isGamePaused {
                if isMovingLeft {
                    player.xScale = 1
                    isMovingLeft = false
                }
                player.position.x -= 3
            } else if location.x > detectTouchLeft && !isGamePaused {
                if !isMovingLeft {
                    player.xScale = -1
                    isMovingLeft = true
                }
                player.position.x += 3
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "retryButton" {
                closePopUpGameOver()
            }
            
            if node.name == "pauseButton"{
                togglePause()
            }
            
            if node.name == "storyButton"{
                createPopUpStory()
            }
            
            if node.name == "resumeButton"{
                togglePause()
            }
            
            if node.name == "next1"{
                createPopUpStory2()
            }
            if node.name == "next2"{
                createPopUpStory3()
            }
            if node.name == "next3"{
                createPopUpStory4()
            }
            
        }
    }

}
