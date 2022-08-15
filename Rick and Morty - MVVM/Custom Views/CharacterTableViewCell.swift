//
//  CharacterTableViewCell.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/8/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var image: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    func setConfiguration(with character: ResultsDictionary) {
        fetchImage(for: character)
        var configuration = defaultContentConfiguration()
        configuration.text = character.name
        configuration.secondaryText = character.species
        configuration.imageProperties.maximumSize = CGSize(width: 100, height: 150)
        contentConfiguration = configuration
    }
    
    func fetchImage(for character: ResultsDictionary) {
        guard let imageString = character.imageString else {return}
        NetworkingController.fetchImage(with: imageString) { result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    
                    self.image = image
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        guard var configuration = contentConfiguration as? UIListContentConfiguration else { return }
        configuration.image = self.image
        contentConfiguration = configuration
    }
    
   
    
} // End of class
