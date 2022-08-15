//
//  CharacterDetailViewModel.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/9/22.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    func characterLoadedSuccessfully()
}

class CharacterDetailViewModel {
    
    private weak var delegate: CharacterDetailViewModelDelegate?
    
    var character: ResultsDictionary?

    
    init(delegate: CharacterDetailViewModelDelegate) {
        self.delegate = delegate

    }
    
    // Fetch the character
    func fetchCharacter(with characterURL: String) {
     
        NetworkingController.fetchCharacter(with: characterURL) { result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self.character = character
                    self.delegate?.characterLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage() {
        
    }
}
