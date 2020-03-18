//
//  SelectFolderVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 27.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class SelectFolderVC: UITableViewController {
    
    // MARK: - Properties
    var note: Note?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "_"
            if note?.folder == nil {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            let folder = folders[indexPath.row - 1]
            cell.textLabel?.text = folder.name
            if folder == note?.folder {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            note?.folder = nil
        } else {
            let folder = folders[indexPath.row - 1]
            note?.folder = folder
        }
        tableView.reloadData()
    }
}
