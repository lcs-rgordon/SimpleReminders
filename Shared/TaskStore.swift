//
//  TaskStore.swift
//  SimpleReminders
//
//  Created by Russell Gordon on 2021-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    
    @Published var tasks: [Task] {
        
        // This property observer will fire when a task is added
        // The existence of this property observer ensures tasks are saved when the app is quit
        didSet {
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(tasks) {
                print("saving")
                UserDefaults.standard.setValue(encoded, forKey: "tasks")
            }
            
        }
        
    }
    
    init(tasks: [Task] = []) {
        
        // Try to read the existing tasks from the app bundle
        if let readItems = UserDefaults.standard.data(forKey: "tasks") {
            
            let decoder = JSONDecoder()
            
            // Try to decode the items from JSON
            // Decodes an instance of the specified type
            // .self is required to reference the type objecct
            // So by saying [Task].self we are saying "decode the data from readItems into a structure of type [Task]"
            if let decoded = try? decoder.decode([Task].self, from: readItems) {
                self.tasks = decoded
            } else {
                self.tasks = []
            }
            return

        } else {
            
            // If nothing could be loaded from the app bundle, or data could not be decoded, show an whatever was passed in to the initializer
            self.tasks = tasks
            
        }
        
    }
}

let testStore = TaskStore(tasks: testData)
