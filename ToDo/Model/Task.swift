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
    
    init(title: String, description: String? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        date = Date()
        self.location = location
    }
}
