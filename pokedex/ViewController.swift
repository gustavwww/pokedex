//
//  ViewController.swift
//  pokedex
//
//  Created by Gustav Wadström on 2016-12-23.
//  Copyright © 2016 Gustav Wadström. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { //Last one setting the layout for the collectionView.

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    
    var inSearchMode = false
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        parseCSV()
        initAudio()
        
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        } catch {
            //Handle the error
            
        }
        
    }
    
    func parseCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, id: id)
                
                pokemon.append(poke)
                
            }
            
        } catch {
            //Handle the error
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            //Loading as many as displayed at a time. Otherwise, app would crash.
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = self.filteredPokemon[indexPath.row]
            } else {
                pokemon = self.pokemon[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            
            poke = self.filteredPokemon[indexPath.row]
            
        } else {
            
            poke = self.pokemon[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "DetailVC", sender: poke)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return self.filteredPokemon.count
        } else {
            return self.pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //Size of cells
        
        return CGSize(width: 105, height: 105)
    }

    @IBAction func musicPressed(_ sender: UIButton) {
        
        if audioPlayer.isPlaying {
            
            audioPlayer.pause()
            sender.alpha = 0.2
        } else {
            
            audioPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true) //Removes keyboard
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Called whenever text in searchbar changes.
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            
            view.endEditing(true) //Removes keyboard
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil }) //$0 is placeholder for each item in the pokemon array.
            collectionView.reloadData()
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailVC {
            
            if let poke = sender as? Pokemon {
                
                destination.pokemon = poke
                
            }
            
        }
        
    }
    
    
    
    
}

