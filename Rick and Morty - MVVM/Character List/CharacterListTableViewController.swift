//
//  CharacterListTableViewController.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/8/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {

    
    var characterListViewModel: CharacterListViewModel!
    var topLevelDictionary: TopLevelDictionary?
    var characterList: [ResultsDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch the character
        characterListViewModel = CharacterListViewModel(delegate: self)
        characterListViewModel.loadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterListViewModel.characterList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell()}
        let character = characterListViewModel.characterList[indexPath.row]
        cell.setConfiguration(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCharacterIndex = characterListViewModel.characterList.count - 1
        if indexPath.row == lastCharacterIndex {
            characterListViewModel.fetchNextPage()
        }
    }
   
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // IIDOO
        if segue.identifier == "toDetailVC" {
            if let destination = segue.destination as? CharacterDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                    // send the data
                    let characterResult = characterListViewModel.characterList[index.row]
                    let characterDetailViewModel = CharacterDetailViewModel(delegate: destination)
                    destination.characterDetailViewModel = characterDetailViewModel
                    characterDetailViewModel.fetchCharacter(with: "\(characterResult.id)")
                    
                }
            }
        }
    }
}
extension CharacterListTableViewController: CharacterListViewModelDelegate {
    func upddateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func characterResultsLoadedSuccessfully() {
        tableView.reloadData()
    }
}









