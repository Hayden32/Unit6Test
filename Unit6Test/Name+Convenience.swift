//
//  Name+Convenience.swift
//  Unit6Test
//
//  Created by Hayden Hastings on 3/17/17.
//  Copyright © 2017 Hayden Hastings. All rights reserved.
//

import Foundation
import CoreData

extension Name {
    
    convenience init(name: String, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        self.name = name
    }
}
