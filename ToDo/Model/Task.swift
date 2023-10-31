//
//  Task.swift
//  ToDo
//
//  Created by Goodwasp on 17.10.2023.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date
    let location: Location?
    
    init(title: String, description: String? = nil, date: Date? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = date ?? Date()
        self.location = location
    }
    
    init?(dict: [String: Any]) {
        title = dict["title"] as! String
        description = dict["description"] as? String
        date = dict["date"] as? Date ?? Date()
        
        if let locationDict = dict["location"] as? [String: Any] {
            location = Location(dict: locationDict)
        } else {
            location = nil
        }
    }
}

// MARK: - Equatable
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if 
            lhs.title == rhs.title,
            lhs.description == rhs.description,
            lhs.location == rhs.location {
            return true
        }
        
        return false
    }
}
