//
//  FetchVideosUseCase.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation
import Alamofire

protocol APIResponse: Decodable {
    associatedtype T: Decodable
    var data: T { get set }
}

struct VideoDTOAPIResponse: APIResponse {
    typealias T = [VideoDTO]
    var data: [VideoDTO]
}

protocol FetchVideosUseCaseProtocol {
    func execute<T: Decodable>(page: Int, searchQueries: [String]?, completion: @escaping (Result<T, Error>) -> Void)
}


class FetchVideosUseCase: FetchVideosUseCaseProtocol {
    
    private let videoRepository: RepositoryProtocol
    
    init(videoRepository: RepositoryProtocol) {
        self.videoRepository = videoRepository
    }
    
    func execute<T: Decodable>(page: Int, searchQueries: [String]?, completion: @escaping (Result<T, Error>) -> Void) {
        
        var parameters: Parameters = [
            "page":page,
            "per_page": 10]
        
//        "page": page, "per_page": 10]
//    if let categories = searchQueries, !categories.isEmpty {
//        for (index, category) in categories.enumerated() {
//            parameters["categories[\(index)]"] = category
//        }
//    }else {
//        var index = 0
//        for cat in Category.allCases {
//            if(cat == Category.all){
//                continue
//            }
//            parameters["categories[\(index)]"] = cat.displayName
//            index += 1
//        }
//    }
//    // default required params
//    parameters["city_id"] = "192957"
//    parameters["latitude"] = "8.12548000"
//    parameters["longitude"] = "7.282820"
//    parameters["type"] = "CITY"
        
        let endPoint = PostListAPIEndpoint.getPostList(parameters: parameters)
        videoRepository.call(endpoint: endPoint, completion: completion)
    }
}
