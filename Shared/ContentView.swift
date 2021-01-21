//
//  ContentView.swift
//  Shared
//
//  Created by Russell Gordon on 2021-01-20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: TaskStore
    
    var body: some View {
        List(store.tasks) { task in
            Text(task.description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}
