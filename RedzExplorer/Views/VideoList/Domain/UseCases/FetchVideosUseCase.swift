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
    typealias T = PostDTO
    var data: PostDTO
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
            "per_page": 10,
            "city_id":"192957",
            "latitude":"8.12548000",
            "longitude":"7.282820",
            "type":"CITY"]
        
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

        
        let endPoint = PostListAPIEndpoint.getPostList(parameters: parameters)
        videoRepository.call(endpoint: endPoint, completion: completion)
    }
}
