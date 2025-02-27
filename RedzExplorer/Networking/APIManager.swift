//
//  APIManager.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation
import Alamofire

protocol DataSource {
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class AFNetworkDataSource: DataSource {
        
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self){ response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
