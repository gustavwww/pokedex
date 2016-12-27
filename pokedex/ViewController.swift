//
//  ViewController.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-23.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { //Last one setting the layout for the collectionView.

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            //Loading as many as displayed at a time. Otherwise, app would crash.
            
            let pokemon = Pokemon(name: "Pokemon", id: indexPath.row)
            cell.configureCell(pokemon: pokemon)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //Size of cells
        
        return CGSize(width: 105, height: 105)
    }

}

