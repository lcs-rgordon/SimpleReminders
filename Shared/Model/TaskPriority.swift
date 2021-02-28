//
//  TaskPriority.swift
//  SimpleReminders
//
//  Created by Russell Gordon on 2021-01-20.
//

import Foundation

enum TaskPriority: String, Decodable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

let noSpecifiedPriorityLevel = "None"
