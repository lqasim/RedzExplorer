//
//  APIManager.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import Foundation
import Alamofire

class APIManager {
    
    //create a shared instance to make apis calls
    static let shared = APIManager()
    
    // Should add if needed , cityid: String?, lat: String?, longitude: String?, loc_type: String?,
    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[Video], Error>) -> Void) {
        
        var urlString = "\(Constants.BASEURL)"
        
        var parameters: [String: Any] = ["page":page]
        parameters["per_page"] = 10
        
        // Providing defaults for required params
        parameters["city_id"] = "192957"
        parameters["latitude"] = "8.12548000"
        parameters["longitude"] = "7.282820"
        parameters["type"] = "CITY"
        
        // If categories are provided, append them to the parameters
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
            .responseDecodable(of: VideoResponse.self) { response in
                switch response.result {
                case .success(let videos):
                    completion(.success(videos.data.posts))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
}
