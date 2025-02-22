//
//  ConstantsTemplate.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import Foundation


struct Constants{
    
    static var BASEURL = "<API_BASE_URL>"
    
    static var REDZ_POST_LIST_API = "\(BASEURL)/{PATH_TO_VIDEO_LIST}"
    
    static let categories: [String] = ["All","RECENT", "NEAREST", "FOLLOWING", "TOP_RAISING", "RECOMMENDED", "POPULAR_TRENDING"]
}
