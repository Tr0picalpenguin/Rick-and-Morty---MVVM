//
//  Character.swift
//  Rick and Morty - MVVM
//
//  Created by Scott Cox on 6/8/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let info: Info
    let results: [ResultsDictionary]
}
struct Info: Decodable {
    private enum CodingKeys: String, CodingKey {
        case nextURL = "next"
    }
    let nextURL: String
}

struct ResultsDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case imageString = "image"
       
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginDictionary
    let location: LocationDictionary
    let imageString: String?
   
}

struct OriginDictionary: Decodable {
    let name: String
}

struct LocationDictionary: Decodable {
    let name: String
}

