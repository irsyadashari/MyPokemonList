//
//  API.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String  { get }
    var parameters: [URLQueryItem] { get }
    var path: String { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
}
