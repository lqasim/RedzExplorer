//
//  APIManager.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void)
}

// implementation is directly put here because of the simple one use case
class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void) {
        
        var urlString = Constants.BASEURL
        var parameters: [String: Any] = ["page":page]
        parameters["per_page"] = 10
        
        // Providing defaults for required params
        parameters["city_id"] = "192957"
        parameters["latitude"] = "8.12548000"
        parameters["longitude"] = "7.282820"
        parameters["type"] = "CITY"
        
        if let categories = searchQueries, !categories.isEmpty {
            for (index, category) in categories.enumerated() {
                parameters["categories[\(index)]"] = category
            }
        } else {
            // If no categories are provided, append a default API endpoint
            urlString += "?\(Constants.REDZ_POST_LIST_API)"
        }
        
        AF.request(urlString, parameters: parameters)
            .validate()
            .responseDecodable (of: VideoResponseDTO.self){ response in
                switch response.result {
                case .success(let videos):
                    completion(.success(videos.data.posts))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
    
}
