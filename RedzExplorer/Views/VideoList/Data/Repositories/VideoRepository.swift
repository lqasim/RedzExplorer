//
//  VideoRepository.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

class Repository: RepositoryProtocol {
    
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func call<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void){
        
        dataSource.request(endpoint: endpoint) { (result: Result<T, Error>) in
            completion(result)
        }
    }
}
