//
//  FileManager.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/24/24.
//

import Foundation

extension FileManager {
    
    static func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
    static func saveDataToFile(filename: String, content: Data) {
        guard let directory = getDocumentsDirectory() else { return }
        
        let fileURL = directory.appendingPathComponent(filename)
        
        do {
            try content.write(to: fileURL)
            print("Data saved to file")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    static func readDataFromFile(filename: String) -> Data? {
        guard let directory = getDocumentsDirectory() else { return nil }
        
        let fileURL = directory.appendingPathComponent(filename)
        
        do {
            let content = try Data(contentsOf: fileURL)
            return content
        } catch {
            print("Error reading file: \(error.localizedDescription)")
            return nil
        }
    }
}
