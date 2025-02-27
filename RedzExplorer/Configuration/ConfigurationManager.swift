//
//  ConfigurationManager.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

// get constants and configurations
class ConfigurationManager {
    
    var configurations: Configurations?
    
    static let shared = ConfigurationManager()
    
    private init() {
        guard let configurationStrings = Bundle.main.url(forResource: "Config", withExtension: "plist") else{
            fatalError("Could not find config.plist ")
        }
        
        do {
            let data = try Data(contentsOf: configurationStrings)
            let decoder = PropertyListDecoder()
            self.configurations = try decoder.decode(Configurations.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func getBaseURL() -> String? {
         return configurations?.APIBASEURL
     }
     
//     func getRedzPostListAPI() -> String? {
//         return configurations?.RedzPostListAPI
//     }
}
