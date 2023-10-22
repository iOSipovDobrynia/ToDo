//
//  DataProvider.swift
//  ToDo
//
//  Created by Goodwasp on 19.10.2023.
//

import UIKit

final class DataProvider: NSObject {
    // MARK: Public properties
    var taskManager: TaskManager?
}

// MARK: - UITableViewDelegate
extension DataProvider: UITableViewDelegate {
     
}

// MARK: - UITableViewDataSource
extension DataProvider: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let taskManager = taskManager else { return 0 }
        return section == 0
        ? taskManager.tasksCount
        : taskManager.doneTasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
        
        guard let taskManager = taskManager else { return UITableViewCell() }
        let task: Task
        
        switch indexPath.section {
        case 0:
            task = taskManager.task(at: indexPath.row)
        default:
            task = taskManager.doneTask(at: indexPath.row)
        }
        cell.configure(with: task)
        return cell
    }
     
}
