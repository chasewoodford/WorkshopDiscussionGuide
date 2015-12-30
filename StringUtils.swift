//
//  StringUtils.swift
//  WorkshopDiscussionGuide
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import Foundation

extension String {
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersInString: matchCharacters).invertedSet
        return self.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
    }
    
}