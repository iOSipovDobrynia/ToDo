//
//  TaskListViewController.swift
//  ToDo
//
//  Created by Goodwasp on 17.10.2023.
//

import UIKit
  
final class TaskListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    // MARK: - View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.taskManager = TaskManager()
    }
    
    // MARK: - IBActions
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            vc.taskManager = dataProvider.taskManager
            present(vc, animated: true)
        }
    }
}
