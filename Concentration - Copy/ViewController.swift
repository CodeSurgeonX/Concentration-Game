//
//  ViewController.swift
//  Concentration - Copy
//
//  Created by Shashwat  on 24/02/19.
//  Copyright © 2019 Shashwat . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet{
            resultLabel.text = "Flips: \(flipCount)"   //Property Observer
        }
    }
    lazy var game = Concentration(numberOfPairsOfCards: buttonCollection.count/2)  //Model VC Connection
    //Lazy var helps delay the initilization, Initilized when needed
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var buttonCollection: [UIButton]!  // Array of UI Type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Flips: "
    }

    @IBAction func flipCards(_ sender: UIButton) {
        guard let index = buttonCollection.index(of:sender) else {fatalError("Button not connected")}
        game.chooseCard(at: index)
        updateUIFromModel()
        flipCount += 1
    }
    
    func updateUIFromModel(){
        
        for index in buttonCollection.indices{
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(forCard : card), for: .normal)
                button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(nil, for: .normal)
                button.backgroundColor = !card.isMatched ? #colorLiteral(red: 1, green: 0.3407757282, blue: 0.0481993109, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
        
        
        var set = Set<Bool>()
        for car in game.cards {
            set.insert(car.isMatched)
        }
        if !set.contains(false){
            let alert = UIAlertController.init(title: "Game Over", message: "Hurray! Wanna play again", preferredStyle: .alert)
            weak var weakSelf = self
            let action = UIAlertAction.init(title: "Start", style: .default) { (alertAction) in
                weakSelf?.flipCount = 0
                weakSelf?.game.restart(numberOfPairsOfCards: (weakSelf?.buttonCollection?.count) ?? 0 / 2)
                weakSelf?.updateUIFromModel()
                weakSelf?.emojiChoices = ["🥶","😎","🧐","🙀","👩🏻‍🦰","💃🏻","👽","👻"] 
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    var emojiChoices = ["🥶","😎","🧐","🙀","👩🏻‍🦰","💃🏻","👽","👻"]  
    var emoji : Dictionary = Dictionary<Int, String>()   //[String:Int]()
    func emoji(forCard : Cards) -> String {
        
        if emoji[forCard.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[forCard.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[forCard.identifier] ?? "?"
    }

    
}

