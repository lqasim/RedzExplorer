//
//  RepositoryProtocol.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation

protocol RepositoryProtocol {
    func call<T:Decodable>(page: Int, searchQueries: [String]?, completion: @escaping (Result<[T], Error>) -> Void)
}
