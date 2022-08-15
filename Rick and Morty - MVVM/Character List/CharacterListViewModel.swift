//
//  CharacterListViewModel.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/9/22.
//

import Foundation

protocol CharacterListViewModelDelegate: AnyObject {
    func characterResultsLoadedSuccessfully()
    func upddateViews()
}


class CharacterListViewModel {
    
    var topLevelDictionary: TopLevelDictionary?
    var characterList: [ResultsDictionary] = []
    private weak var delegate: CharacterListViewModelDelegate?
    
    init(delegate: CharacterListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadData() {
        fetchCharacterList { result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self.characterList = character
                    self.delegate?.characterResultsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCharacterList(completion: @escaping (Result<[ResultsDictionary], NetworkError>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(.badURL)) ; return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(topLevelDictionary.results))
            } catch {
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    func fetchNextPage() {
        guard let topLevelDictionary = topLevelDictionary else {
            return
        }
        guard let url = URL(string: topLevelDictionary.info.nextURL) else { return }
        NetworkingController.fetchTopLevelDictionary(with: url) { result in
            switch result {
            case .success(let topLevelDict):
                self.topLevelDictionary = topLevelDict
                self.characterList.append(contentsOf: topLevelDict.results)
                DispatchQueue.main.async {
                    self.delegate?.upddateViews()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
