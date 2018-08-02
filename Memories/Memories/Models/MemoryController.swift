//
//  MemoryController.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import Foundation

private let memoriesPList = "memoriesPList"

class MemoryController {
    
    // array object
    var memories : [Memory] = []
    
    // computed property that uses the `FileManager` class to get the document directory URL and append a filename and extension for the plist such as "memories.plist" to it, then returns that URL.
    var persistentFileURL : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(memoriesPList)
    }
    
    // encode the memories array and write that data to the device's storage using the persistentFileURL computed property
    func saveToPersistentStore() {
        
        do {
            guard let url = persistentFileURL else { return }
            
            let encoder = PropertyListEncoder()
            let memoriesData = try encoder.encode(memories)
            try memoriesData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    // get the plist data from the persistentFileURL using the `Data(contentsOf: URL)` initializer, decode the memories plist data back into an array of Memory objects, and set the model controller's memories variable to these newly decoded Memory objects
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
            
            let memoriesData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
            memories = decodedMemories
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
    
    func createAMemory(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    func updateAMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    func deleteAMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }
}
