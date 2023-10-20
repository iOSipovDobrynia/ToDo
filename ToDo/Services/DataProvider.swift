//
//  DataProvider.swift
//  ToDo
//
//  Created by Goodwasp on 19.10.2023.
//

import UIKit

class DataProvider: NSObject {
    
}

extension DataProvider: UITableViewDelegate {
     
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
     
}
