//
//  TaskManager.swift
//  ToDo
//
//  Created by Goodwasp on 19.10.2023.
//

import Foundation

final class TaskManager {
    var taskCount: Int {
        tasks.count
    }
    var doneTaskCount: Int {
        doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
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
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
