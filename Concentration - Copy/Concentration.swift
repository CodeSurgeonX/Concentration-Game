//
//  Concentration.swift
//  Concentration - Copy
//
//  Created by Shashwat  on 24/02/19.
//  Copyright © 2019 Shashwat . All rights reserved.
//

import Foundation
class Concentration {
    var cards = Array<Cards>()
    var indexOfOneAndOnlyOne : Int?
    
    func chooseCard(at index : Int) {
        
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyOne, matchedIndex != index {
                //Checks if card matches the indexOfOneAndOnlyOne, and doesnt match with itself
                
                //Checks if cards match
                if cards[matchedIndex].identifier == cards[index].identifier{
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOne = nil
            }else{
                //Either no card or two cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                    //Flips down all the open cards
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOne = index
                //Sets one and only one for the next conditions
            }
        }
        
        //If it is matched no need to do anything since it is already hidden
    }
    
    init(numberOfPairsOfCards : Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Cards()
//            cards += [card,card]
            cards.append(card)
            cards.append(card)
        }
        print(cards.count)
        //TODO: Shuffle Cards
        
        cards.shuffle()
    }
    
    func restart(numberOfPairsOfCards : Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Cards()
            //            cards += [card,card]
            cards.append(card)
            cards.append(card)
        }
        print(cards.count)
        //TODO: Shuffle Cards
        
        cards.shuffle()
    }
    
}
