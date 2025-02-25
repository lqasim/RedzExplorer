//
//  Constants.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import Foundation


struct Constants {

    static var BASEURL = "https://backend.redzapp.net/api/posts/suggestions/public"

    static var REDZ_POST_LIST_API = "&categories%5B%5D=RECENT&categories%5B%5D=NEAREST&catego%20ries%5B%5D=FOLLOWING&categories%5B%5D=TOP_RAISING&cate%20gories%5B%5D=RECOMMENDED&categories%5B%5D=POPULAR_TRENDING&city_id=192957&latitude=48.12548000&longitude=7.282820&type=CITY"

    static let categories: [String] = ["All","RECENT", "NEAREST", "FOLLOWING", "TOP_RAISING", "RECOMMENDED", "POPULAR_TRENDING"]
}
