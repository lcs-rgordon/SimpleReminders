//
//  TaskStore.swift
//  SimpleReminders
//
//  Created by Russell Gordon on 2021-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task]
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
}

let testStore = TaskStore(tasks: testData)
