//
//  CharacterDetailViewController.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/9/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var characterImageView: CharacterImageView!
    
    
    var characterDetailViewModel: CharacterDetailViewModel! = nil
    var characters: ResultsDictionary? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Display the details of the character
    func updateViews() {
        guard let character = characterDetailViewModel.character else { return }
        characterNameLabel.text = character.name.capitalized
        statusLabel.text = character.status.capitalized
        speciesLabel.text = character.species.capitalized
        genderLabel.text = character.gender.capitalized
        idLabel.text = "Character No: \(character.id)"
        
        // getting bad access error for the image :/ this is something that needs to be fixed
        
//        if let imageURL = character.imageString {
//            self.characterImageView.fetchImage(using: imageURL)
//        }
        
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func characterLoadedSuccessfully() {
        self.updateViews()
    }
}
