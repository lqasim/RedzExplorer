//
//  APIEndpoint.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation
import Alamofire

protocol APIEndpoint: URLRequestConvertible {
    var baseUrl: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
}

extension APIEndpoint {
    var baseUrl: String {
        return ConfigurationManager.shared.getBaseURL()!
    }
    
    var parameters: Parameters? {
        return nil
    }
}


