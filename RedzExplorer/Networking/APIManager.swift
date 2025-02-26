//
//  APIManager.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    func request<T>(endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: responseType){ response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
}
