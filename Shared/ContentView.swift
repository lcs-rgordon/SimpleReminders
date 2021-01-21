//
//  ContentView.swift
//  Shared
//
//  Created by Russell Gordon on 2021-01-20.
//

import SwiftUI

struct ContentView: View {
    
    // Stores all tasks being tracked
    @ObservedObject var store: TaskStore
    
    // Controls whether the add task view is showing
    @State private var showingAddTaskView = false
    
    var body: some View {
        List(store.tasks) { task in
            TaskCell(task: task)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTaskView = true
                }
            }
        }
        .sheet(isPresented: $showingAddTaskView) {
            AddTaskView(store: store, showing: $showingAddTaskView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
