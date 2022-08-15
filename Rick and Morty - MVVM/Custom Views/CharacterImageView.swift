//
//  CharacterImageView.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 8/14/22.
//

import Foundation
import UIKit

class CharacterImageView: UIImageView {

    func fetchImage(using urlString: String) {
        NetworkingController.fetchImage(with: urlString ) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.contentMode = .scaleAspectFit
                    self?.image = image
                }
            case .failure:
                self?.setDefaultImage()
            }
        }
    }
    func setDefaultImage() {
        contentMode = .scaleAspectFit
        self.image = UIImage(systemName: "ticket")
    }
}
