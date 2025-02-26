//
//  APIManager.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

//import Foundation
//import Alamofire
//
//protocol APIManagerProtocol {
//    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
//}
//
//class APIManager: APIManagerProtocol {
//
//    static let shared = APIManager()
//
//    func request<T>(endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
//        AF.request(endpoint)
//            .validate()
//            .responseDecodable(of: responseType){ response in
//                switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//
//            }
//    }
//}
    
//
//    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void) {
//
//        guard var urlString = ConfigurationManager.shared.getBaseURL() else{
//            return
//        }
//        var parameters: [String: Any] = ["page":page]
//        parameters["per_page"] = 10
//
//        // Providing defaults for required params
//        parameters["city_id"] = "192957"
//        parameters["latitude"] = "8.12548000"
//        parameters["longitude"] = "7.282820"
//        parameters["type"] = "CITY"
//
//        if let categories = searchQueries, !categories.isEmpty {
//            for (index, category) in categories.enumerated() {
//                parameters["categories[\(index)]"] = category
//            }
//        } else {
//            // If no categories are provided, append a default API endpoint
//            if let basePostApi = ConfigurationManager.shared.getRedzPostListAPI() {
//                urlString += "?\(basePostApi)"
//            }
//        }
//
//        AF.request(urlString, parameters: parameters)
//            .validate()
//            .responseDecodable (of: VideoResponseDTO.self){ response in
//                switch response.result {
//                case .success(let videos):
//                    completion(.success(videos.data.posts))
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//
//            }
//    }
    

