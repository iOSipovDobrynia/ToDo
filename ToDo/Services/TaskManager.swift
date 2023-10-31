//
//  TaskManager.swift
//  ToDo
//
//  Created by Goodwasp on 19.10.2023.
//

import Foundation
import UIKit

final class TaskManager {
    
    // MARK: - Public properties
    var tasksCount: Int {
        tasks.count
    }
    var doneTasksCount: Int {
        doneTasks.count
    }
    
    var tasksURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            fatalError()
        }
        
        return documentURL.appendingPathComponent("tasks", conformingTo: .propertyList)
    }
    
    // MARK: - Private properties
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        if let data = try? Data(contentsOf: tasksURL) {
            guard let dicts = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]] else {
                return
            }
            
            for dict in dicts {
                if let task = Task(dict: dict) {
                    tasks.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
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
    
    @objc
    func save() {
        let taskDicts = tasks.map { $0.dict }
        guard taskDicts.count > 0 else {
            try? FileManager.default.removeItem(at: tasksURL)
            return
        }
        
        let plistData = try? PropertyListSerialization.data(
            fromPropertyList: taskDicts,
            format: .xml,
            options: PropertyListSerialization.WriteOptions(0)
        )
        
        try? plistData?.write(to: tasksURL, options: .atomic)
    }
}
