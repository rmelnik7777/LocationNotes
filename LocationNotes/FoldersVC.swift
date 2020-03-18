//
//  FoldersVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 22.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class FoldersVC: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var backToMenuButton: UIBarButtonItem!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shareInstance.requestAutorization()
        preepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UI
    func preepareUI() {
        backToMenuButton.title = "в МЕНЮ"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFolder", for: indexPath)
        let folderInCell = folders[indexPath.row]
        cell.textLabel?.text = folderInCell.name
        cell.detailTextLabel?.text = "\(folderInCell.notes!.count) item(-s)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = folders[indexPath.row]
        performSegue(withIdentifier: "goToFolder", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let folderInCell = folders[indexPath.row]
            CoreDataManager.sharedInstance.managedObjecContext.delete(folderInCell)
            CoreDataManager.sharedInstance.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFolder" {
            let selectedFolder = folders[tableView.indexPathForSelectedRow!.row]
            (segue.destination as? FolderVC)?.folder = selectedFolder
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        Router.shared.showInitialVC()
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new folder", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { text in
            text.placeholder = "Folder name"
        }
        
        let alertActionAdd = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { _ in
            var folderName = alertController.textFields?[0].text
            if folderName!.isEmpty {
                folderName =  "NEW FOLDER"
            }
            _ = Folder.newFolder(name: folderName!.uppercased())
            CoreDataManager.sharedInstance.saveContext()
            self.tableView.reloadData()
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { _ in
            
        }
        alertController.addAction(alertActionAdd)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
        
        tableView.reloadData()
    }
    
}
