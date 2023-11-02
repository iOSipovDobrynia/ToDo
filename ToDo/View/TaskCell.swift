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
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter
    }
    
    // MARK: - Public methods
    func configure(with task: Task, done: Bool = false) {
        if !done {
            titleLabel.text = task.title
            let date = task.date
            dateLabel.text = dateFormatter.string(from: date)
            locationLabel.text = task.location?.name
        } else {
            let attributedString = NSAttributedString(
                string: task.title,
                attributes: [
                    NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
                ]
            )
            
            titleLabel.attributedText = attributedString
            dateLabel.text = ""
            locationLabel.text = ""
        }
    }
}
