//
//  Pokemon.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-23.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String
    private var _id: Int
    
    private var _desc: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    
    private var _pokemonURL: String
    
    
    var desc: String {
        if _desc == nil {
            _desc = ""
        }
        
        return _desc
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        
        return _baseAttack
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        
        return _nextEvoTxt
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        
        return _nextEvoName
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        
        return _nextEvoId
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        
        return _nextEvoLevel
    }
    
    
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int) {
        
        self._name = name
        self._id = id
        
        self._pokemonURL = URL_BASE + URL_POKEMON + "\(_id)"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._baseAttack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                             self._type! += "/\(name.capitalized)"
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    if let desc = dict["descriptions"] as? [Dictionary<String, String>] , desc.count > 0 {
                        
                        if let url = desc[0]["resource_uri"] {
                            
                            let descURL = "\(URL_BASE)\(url)"
                            
                            Alamofire.request(descURL).responseJSON(completionHandler: { response in
                                
                                let res = response.result
                                
                                if let descDict = res.value as? Dictionary<String, AnyObject> {
                                    
                                    if let desc = descDict["description"] as? String {
                                        
                                        let newDesc = desc.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        
                                        self._desc = newDesc
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                                completed()
                            })
                            
                            
                        }
                        
                        
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            
                            if nextEvo.range(of: "mega") == nil {
                                
                                self._nextEvoName = nextEvo
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvoId = nextEvoId
                                    
                                    if let lvlExists = evolutions[0]["level"] {
                                        
                                        if let lvl = lvlExists as? Int {
                                            
                                            self._nextEvoLevel = "\(lvl)"
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
            
            completed()
        }
        
    }
    
    
}
