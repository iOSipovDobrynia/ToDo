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
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        indexPath.section == 0 ? "Done" : "Undone"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let task = taskManager!.task(at: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectRow notification"), object: self, userInfo: ["task": task])
        }
    }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            taskManager?.checkTask(at: indexPath.row)
        default:
            taskManager?.uncheckTask(at: indexPath.row)
        }
        tableView.reloadData()
 
    }
     
}
