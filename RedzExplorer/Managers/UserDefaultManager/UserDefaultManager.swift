//
//  UserDefaultManager.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import Foundation

// Enum to define user defaults keys
enum UserDefaultsKey: String {
    case likedVideoKey = "likedVideoKey"
}

protocol UserPersistence {
    // Generic methods for persistence
    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKey)
    func retrieve<T: Codable>(forKey key: UserDefaultsKey, as type: T.Type) -> [T]?
    func remove<T: Codable>(_ value: T, forKey key: UserDefaultsKey)
}

struct UserDefaultsManager: UserPersistence {
    
    // MARK: - SAVE DATA
    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKey) {
        var data = retrieve(forKey: key, as: T.self) ?? []
//        print(data[0])
        data.append(value)
        do {
            let encodedData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encodedData, forKey: key.rawValue)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    // MARK: - RETRIEVE DATA
    func retrieve<T: Codable>(forKey key: UserDefaultsKey, as type: T.Type) -> [T]? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        do {
            let decodedData = try JSONDecoder().decode([T].self, from: data)
            return decodedData
        } catch {
            print("Error decoding data: \(error)")
            return nil
        }
    }
    
    // MARK: - REMOVE DATA
    func remove<T: Codable>(_ value: T, forKey key: UserDefaultsKey) {
        var data = retrieve(forKey: key, as: T.self) ?? []
        
        // Check if the value exists and remove it
        if let index = data.firstIndex(where: { (item) -> Bool in
            return areEqual(item, value)
        }) {
            data.remove(at: index)
            do {
                let encodedData = try JSONEncoder().encode(data)
                UserDefaults.standard.set(encodedData, forKey: key.rawValue)
            } catch {
                print("Error encoding data: \(error)")
            }
        }
    }
    
    // MARK: - Helper method to compare Codabs
    private func areEqual<T: Codable>(_ lhs: T, _ rhs: T) -> Bool {
        return "\(lhs)" == "\(rhs)"
    }
}

