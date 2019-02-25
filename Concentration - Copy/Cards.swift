//
//  Cards.swift
//  Concentration - Copy
//
//  Created by Shashwat  on 24/02/19.
//  Copyright © 2019 Shashwat . All rights reserved.
//

import Foundation
struct Cards {
    static var identifierFactory = 0
    static func getIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory                //Generates unique identifier for two cards
    }
    var isFaceUp = false
    var isMatched = false
    var identifier : Int = getIdentifier()
}
