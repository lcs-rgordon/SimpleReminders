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
    @State private var showingAddTask = false
    
    var body: some View {
        List(store.tasks) { task in
            TaskCell(task: task)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(store.tasks) {
                print("saving")
                UserDefaults.standard.setValue(encoded, forKey: "tasks")
            }

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
