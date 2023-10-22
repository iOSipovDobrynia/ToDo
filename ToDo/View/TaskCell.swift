//
//  TaskCell.swift
//  ToDo
//
//  Created by Goodwasp on 21.10.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK: - Public methods
    func configure(with task: Task) {
        titleLabel.text = task.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: task.date)
        
        if let locationName = task.location?.name {
            locationLabel.text = locationName
        }
    }
}
