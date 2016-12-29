//
//  DetailVC.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-28.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeName.text = pokemon.name.capitalized
        idLbl.text = "\(pokemon.id)"
        mainImg.image = UIImage(named: "\(pokemon.id)")
        currentEvoImg.image = UIImage(named: "\(pokemon.id)")
        
        pokemon.downloadPokemonDetails {
            //Download complete.
            
            self.updateUI()
            
        }
        
        
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.baseAttack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        
        descLbl.text = pokemon.desc
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLbl.text = str
        }
        
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
