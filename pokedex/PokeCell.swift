//
//  PokeCell.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-24.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
       nameLbl.text = pokemon.name.capitalized
       pokeImg.image = UIImage(named:"\(pokemon.id)")
        
    }
    
}
