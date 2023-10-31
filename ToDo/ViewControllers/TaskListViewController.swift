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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(with:)), name: NSNotification.Name(rawValue: "didSelectRow notification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            vc.taskManager = dataProvider.taskManager
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    // MARK: - Methods
    @objc
    private func showDetail(with notification: Notification) {
        guard 
            let userInfo = notification.userInfo,
            let task = userInfo["task"] as? Task,
            let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
            fatalError()
        }
        
        detailVC.task = task
        navigationController?.pushViewController(detailVC, animated: true)
        modalPresentationStyle = .fullScreen
    }
}
