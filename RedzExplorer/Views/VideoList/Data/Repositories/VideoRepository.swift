//
//  VideoRepository.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

class VideoRepository: RepositoryProtocol {
    
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func call<T>(page: Int, searchQueries: [String]?, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        var parameters: [String: Any] = ["page": page, "per_page": 10]
        if let categories = searchQueries, !categories.isEmpty {
            for (index, category) in categories.enumerated() {
                parameters["categories[\(index)]"] = category
            }
        }else {
            var index = 0
            for cat in Category.allCases {
                if(cat == Category.all){
                    continue
                }
                parameters["categories[\(index)]"] = cat.displayName
                index += 1
            }
        }
        // default required params
        parameters["city_id"] = "192957"
        parameters["latitude"] = "8.12548000"
        parameters["longitude"] = "7.282820"
        parameters["type"] = "CITY"
        
        let endPoint = PostListAPIEndpoint.getPostList(parameters: parameters)
        
        apiManager.request(endpoint: endPoint, responseType: VideoResponseDTO.self) { result in
            switch result {
            case .success(let response):
                if let videos = response.data.posts as? [T] {
                    completion(.success(videos))
                } else {
                    completion(.failure("Unable to decode Data" as! Error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
