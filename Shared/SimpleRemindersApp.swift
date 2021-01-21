//
//  SimpleRemindersApp.swift
//  Shared
//
//  Created by Russell Gordon on 2021-01-20.
//

import SwiftUI

@main
struct SimpleRemindersApp: App {
    
    @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(store: store)
            }
        }
    }
}
