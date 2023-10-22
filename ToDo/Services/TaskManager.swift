//
//  TaskManager.swift
//  ToDo
//
//  Created by Goodwasp on 19.10.2023.
//

import Foundation

final class TaskManager {
    
    // MARK: - Public properties
    var tasksCount: Int {
        tasks.count
    }
    var doneTasksCount: Int {
        doneTasks.count
    }
    
    // MARK: - Private properties
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    // MARK: - Public methods
    func add(_ task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        tasks[index]
    }
    
    func doneTask(at index: Int) -> Task {
        doneTasks[index]
    }
    
    func checkTask(at index: Int){
        let doneTask = tasks.remove(at: 0)
        doneTasks.append(doneTask)
    }
    
    func uncheckTask(at index: Int){
        let task = doneTasks.remove(at: 0)
        tasks.append(task)
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
