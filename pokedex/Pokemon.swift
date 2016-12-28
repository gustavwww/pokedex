//
//  Pokemon.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-23.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _id: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int) {
        
        self._name = name
        self._id = id
        
    }
    
    
    
    
    
    
    
}
