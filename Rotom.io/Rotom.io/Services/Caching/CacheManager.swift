//
//  CacheManager.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/24/24.
//

// MARK: Cache Manager
import Foundation


// MARK: - - Service
class CacheManager {
    
    
    // MARK: - -- Properties
    static let shared = CacheManager()
    private let cache = NSCache<NSString, NSData>()
    
    // MARK: - -- Lifecycle
    private init() {
    }
    
    
    // MARK: - -- Methods
    func getImage(forKey key: String) -> NSData? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ imageData: NSData, forKey key: String) {
        cache.setObject(imageData, forKey: key as NSString)
    }
}
