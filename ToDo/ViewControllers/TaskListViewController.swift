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
    }
    
    // MARK: - IBActions
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) {
            present(vc, animated: true)
        }
    }
}
