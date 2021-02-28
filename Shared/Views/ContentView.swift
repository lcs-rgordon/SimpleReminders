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
    
    // What the user is searching for
    @State private var searchText: String = ""
    
    // What to filter upon
    @State private var selectedPriorityLevel = noSpecifiedPriorityLevel

    // Controls whether the add task view is showing
    @State private var showingAddTask = false
    
    var body: some View {
        
        VStack {
            
            Text("Filter by...".uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
            
            Picker("Priority", selection: $selectedPriorityLevel) {
                Text(noSpecifiedPriorityLevel).tag(noSpecifiedPriorityLevel)
                Text(TaskPriority.low.rawValue).tag(TaskPriority.low.rawValue)
                Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium.rawValue)
                Text(TaskPriority.high.rawValue).tag(TaskPriority.high.rawValue)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            List(store.filteredTasks(with: selectedPriorityLevel)) { task in
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
