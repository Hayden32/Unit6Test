//
//  NameController.swift
//  Unit6Test
//
//  Created by Hayden Hastings on 3/17/17.
//  Copyright © 2017 Hayden Hastings. All rights reserved.
//

import Foundation
import CoreData

class NameController {
    
    static let shared = NameController()
    
    var name: [Name] {
        let request: NSFetchRequest<Name> = Name.fetchRequest()
        let moc = Stack.context
        
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            
            return []
        }
    }
    
    var sections: Int {
        let count = name.count / 2
        return name.count % 2 == 0 ? count : count + 1
    }
    
    let namesPerSection = 2
    
    // CRUD
    
    func addNames(name: String) -> Name {
        let name = Name(name: name)
        saveToPersistentStorage()
        return name
    }
    
    func deleteNames(name: Name) {
        let moc = Stack.context
        moc.delete(name)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        let moc = Stack.context
        do {
            try moc.save()
        } catch {
            print("Error: Could not save from persistent storage.")
        }
    }
    
}
extension Array {
    mutating func randomize() {
        for index in stride(from: count - 1 , through: 1, by: -1) {
            let random = Int(arc4random_uniform(UInt32(index+1)))
            if index != random {
                swap(&self[index], &self[random])
            }
        }
        
    }
}
