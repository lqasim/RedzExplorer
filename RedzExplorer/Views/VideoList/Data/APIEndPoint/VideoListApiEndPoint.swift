//
//  APIEndPoint.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation
import Alamofire

enum PostListAPIEndpoint: APIEndpoint {
    
    case getPostList(parameters: Parameters)

    var path: String {
        switch self {
        case .getPostList:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPostList:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try self.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.method = self.method
        
        switch self {
        case .getPostList(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
