//
//  NetworkingController.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/8/22.
//

import Foundation
import UIKit.UIImage
import UIKit

class NetworkingController {
    
    private static let baseURLString = "https://rickandmortyapi.com/api/character"
  
    
    static func fetchTopLevelDictionary(with url: URL, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void ) {
        guard let baseURL = URL(string:baseURLString) else { return }
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("There was an error fetching the data. The url is \(baseURL), the error is \(error.localizedDescription)")
                      completion(.failure(.badURL))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
        }
            do {
                let characterList = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(characterList))
            } catch {
                print("Error!", error.localizedDescription)
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    static func fetchCharacter(with urlString: String, completion: @escaping (Result<ResultsDictionary, NetworkError>) -> Void) {
        guard var characterURL = URL(string: baseURLString) else {
            completion(.failure(.badURL))
            return
        }
        characterURL.appendPathComponent(urlString)
        
        URLSession.shared.dataTask(with: characterURL) { data, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let characterData = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let character = try JSONDecoder().decode(ResultsDictionary.self, from: characterData)
                completion(.success(character))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                      completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
 
    static func fetchImage(with imageString: String, completion: @escaping(Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: imageString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Encountered Error: \(error.localizedDescription)")
                completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.errorDecoding(error!)))
                return
            }
            completion(.success(image))
        }.resume()
    }
}
